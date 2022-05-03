import { Schema } from 'mongoose';

export const ProductsSchema = new Schema(
  {
    nome: {
      type: String,
    },
    estoque: {
      type: Number,
    },
    preco_custo: {
      type: Number,
    },
    preco_venda: {
      type: Number,
    },
  },
  {
    timestamps: true,
    collection: 'products',
  },
);
