import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { UpsertProductDTO } from './dtos/upsert_product.dto';
import { ProductsInterface } from './interfaces/products.interface';
import { ProductsService } from './products.service';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Post()
  async criarProduct(
    @Body() criarProductDTO: UpsertProductDTO,
  ): Promise<ProductsInterface> {
    return await this.productsService.createProduct(criarProductDTO);
  }

  @Get()
  async consultarProducts(): Promise<Array<ProductsInterface>> {
    return await this.productsService.consultarTodasProducts();
  }

  @Get('/:product')
  async consultarProductPeloID(
    @Param('product')
    product: string,
  ): Promise<ProductsInterface> {
    return await this.productsService.consultarProductPeloID(product);
  }

  @Put('/:product')
  async atualizarProduct(
    @Body() atualizarProductDTO: UpsertProductDTO,
    @Param('product') product: string,
  ): Promise<void> {
    await this.productsService.atualizarProduct(product, atualizarProductDTO);
  }

  @Delete('/:_id')
  async deletarProduct(@Param('_id') _id: string): Promise<ProductsInterface> {
    return await this.productsService.deletarProduct(_id);
  }
}
