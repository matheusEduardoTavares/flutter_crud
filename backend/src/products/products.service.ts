import { Injectable, NotFoundException, Query } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose/dist/common/mongoose.decorators';
import { Model } from 'mongoose';
import { Encrypt } from 'src/encrypt/encrypt';
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
    const productCriada = new this.productModel({
      ...createProductDTO,
      nome: await Encrypt.encrypt(createProductDTO.nome),
    });

    return productCriada.save();
  }

  async consultarTodasProducts(isEncrypt: boolean): Promise<Array<any>> {
    const data = await this.productModel.find().exec();

    if (isEncrypt === false) {
      return data;
    }

    const promises = data.map(async (e) => {
      return new this.productModel({
        ...e,
        id: e._id.id.toString(),
        nome: await Encrypt.descrypt(e.toObject().nome),
        estoque: e.toObject().estoque,
        preco_custo: e.toObject().preco_custo,
        preco_venda: e.toObject().preco_venda,
        createdAt: e._id.getTimestamp(),
      });
    });

    const result = await Promise.all(promises);

    return result;
    // return data.map((e) => {
    //   const eObject = e.toObject();
    //   console.log(eObject.nome);
    //   console.log(eObject.preco_custo);
    //   // return e;
    //   return {
    //     // id: e._id.id.toString(),
    //     // nome: await Encrypt.descrypt(eObject.nome),
    //     estoque: eObject.estoque,
    //     preco_custo: eObject.preco_custo,
    //     preco_venda: eObject.preco_venda,
    //     // createdAt: e._id.getTimestamp(),
    //   };
    // });
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
          $set: {
            ...atualizarProductDTO,
            nome: await Encrypt.encrypt(atualizarProductDTO.nome),
          },
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
