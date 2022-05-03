import { Injectable, NotFoundException, Query } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose/dist/common/mongoose.decorators';
import { Model } from 'mongoose';
import { UpsertProductDTO } from './dtos/upsert_product.dto';
import { ProductsInterface } from './interfaces/products.interface';

@Injectable()
export class ProductsService {
  constructor(
    @InjectModel('Products')
    private readonly productModel: Model<ProductsInterface>,
  ) {}

  async createProduct(
    createProductDTO: UpsertProductDTO,
  ): Promise<ProductsInterface> {
    const productCriada = new this.productModel(createProductDTO);

    return productCriada.save();
  }

  async consultarTodasProducts(
    @Query('isEncrypt') isEncrypt: string,
  ): Promise<Array<ProductsInterface>> {
    return await this.productModel.find().exec();
  }

  async consultarProductPeloID(product: string): Promise<ProductsInterface> {
    const productEncontrada = await this.productModel
      .findOne({
        product,
      })
      .exec();

    if (!productEncontrada) {
      throw new NotFoundException(`Product ${product} não encontrada!`);
    }

    return productEncontrada;
  }

  async atualizarProduct(
    product: string,
    atualizarProductDTO: UpsertProductDTO,
  ) {
    const productEncontrada = await this.productModel.findOne({
      product,
    });

    if (!productEncontrada) {
      throw new NotFoundException(`Product ${product} não encontrada!`);
    }

    await this.productModel
      .findOneAndUpdate(
        {
          product,
        },
        {
          $set: atualizarProductDTO,
        },
      )
      .exec();
  }

  async deletarProduct(_id: string): Promise<any> {
    const product = await this.productModel.findOne({ _id }).exec();

    if (!product) {
      throw new NotFoundException(`Product com id ${_id} não encontrado`);
    }

    return await this.productModel
      .deleteOne({
        _id,
      })
      .exec();
  }
}
