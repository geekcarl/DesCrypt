#ifndef ___DES__HHH
#define ___DES__HHH

// void des_encode(unsigned char des_key[8], unsigned char *in, unsigned char *out);

// void des_decode(unsigned char des_key[8], unsigned char *in, unsigned char *out);

void des_encode_var(unsigned char *des_key, unsigned char *dest, unsigned char *dest_len, unsigned char *src, unsigned char src_len);

void des_decode_var(unsigned char *des_key, unsigned char *dest, unsigned char *dest_len, unsigned char *src, unsigned char src_len);

#endif
//////

