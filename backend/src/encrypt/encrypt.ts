import { createCipheriv, createDecipheriv, randomBytes, scrypt } from 'crypto';
import { promisify } from 'util';

export class Encrypt {
  static async encrypt(data: string): Promise<string> {
    const iv = randomBytes(16);
    const password = '123456';

    const key = (await promisify(scrypt)(password, 'salt', 32)) as Buffer;
    const cipher = createCipheriv('aes-256-ctr', key, iv);

    const encryptedText = Buffer.concat([cipher.update(data), cipher.final()]);

    return encryptedText.toString();
  }

  static async descrypt(data: string): Promise<string> {
    const iv = randomBytes(16);
    const password = '123456';

    const key = (await promisify(scrypt)(password, 'salt', 32)) as Buffer;
    const decipher = createDecipheriv('aes-256-ctr', key, iv);
    const cipher = createCipheriv('aes-256-ctr', key, iv);

    const encryptedText = Buffer.concat([cipher.update(data), cipher.final()]);

    const decryptedText = Buffer.concat([
      decipher.update(encryptedText),
      decipher.final(),
    ]);

    return decryptedText.toString();
  }
}
