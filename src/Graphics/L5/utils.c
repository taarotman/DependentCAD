/* #include <stdio.h> */
/* #include <stdlib.h> */
/* #include <math.h> */
/* #include <stdbool.h> */
/* #include </home/alfie/.nix-profile/include/libfive.h> */
/* #include <cstdint> */
/* #include <stdint.h> */
/* #include <stdbool.h> */

/* #ifdef __cplusplus */
/* /\* #include <cstdint> *\/ */
/* extern "C" */
/* { */
/* #endif */

/* typedef char* (*print) (libfive_tree tree); */

/* typedef libfive_mesh* (*render) (libfive_tree tree, */
/*                                  libfive_region3 R, */
/*                                  float res); */

/* typedef bool (*save) (libfive_tree tree, */
/*                       libfive_region3 R, */
/*                       float res, */
/*                       const char* f); */
/* /\* typedef bool (*save) (); *\/ */

/* char* string_fix(const char* str) */
/* { */
/*   const char* str_; */
/*   str_ = str; */
/*   /\* printf("string_fix: %s\n", str_); *\/ */
/*   return str_; */
/* } */

/* void print_region3(libfive_region3 R) */
/* { */
/*   printf("region:\n"); */
/*   printf("%f\n", R.X.lower); */
/*   printf("%f\n", R.X.upper); */
/*   printf("%f\n", R.Y.lower); */
/*   printf("%f\n", R.Y.upper); */
/*   printf("%f\n", R.Z.lower); */
 
/* } */

/* char* string_test(const char* fst, const char* snd) */
/* { */
/*   return snd; */
/* } */
  
/* char* libfive_tree_save_mesh_args(const char* f, */
/*                                   libfive_tree tree, */
/*                                   libfive_region3 R, */
/*                                   float res) */
/* { */
/*   static const char* str; */
/*   /\* str = string_fix(f); *\/ */
/*   printf("quality: %f\n", res); */
/*   printf("previous filename: %s\n", f); */
/*   str = f; */
/*   printf("libfive_tree_save_mesh_fix filename: %s\n", str); */
/*   return str; */

/*   /\* bool result; *\/ */
/*   /\* /\\* result = savefun(tree, R, res, string_fix(f)); *\\/ *\/ */
/*   /\* result = savefun(tree, R, res, str); *\/ */
/*   /\* /\\* return savefun(tree, R, res, str); *\\/ *\/ */
/*   /\* return result; *\/ */
/*   /\* //return true; *\/ */
/* } */

/* bool libfive_tree_render_mesh_fix(libfive_tree* tree, */
/*                                   libfive_region3* R, */
/*                                   float res, */
/*                                   render renderfun) */
/* { */
/*   libfive_region3 Rs; */
/*   Rs = *R; */
/*   printf("region3 check:\n"); */
/*   printf("%f\n", Rs.X.lower); */
/*   printf("%f\n", Rs.X.upper); */
/*   printf("%f\n", Rs.Y.lower); */
/*   printf("%f\n", Rs.Y.upper); */
/*   printf("%f\n", Rs.Z.lower); */
/*   printf("%f\n", Rs.Z.upper); */
  
/*   return renderfun(tree, Rs, res); */
/* } */

/* bool libfive_tree_save_mesh_fix(libfive_tree* tree, */
/*                                 libfive_region3* R, */
/*                                 float res, */
/*                                 const char* f, */
/*                                 print printfun, */
/*                                 save savefun) */
/* { */
/*   /\* const char* str; *\/ */
/*   /\* /\\* str = string_fix(f); *\\/ *\/ */
/*   printf("save_mesh: tree will be put in: %s\n", f); */
/*   printf("resolution: %f\n", res); */
/*   /\* str = f; *\/ */
/*   /\* printf("libfive_tree_save_mesh_fix filename: %s\n", str); *\/ */

/*   libfive_region3 Rs; */
/*   Rs = *R; */
/*   printf("region3 check:\n"); */
/*   printf("%f\n", Rs.X.lower); */
/*   printf("%f\n", Rs.X.upper); */
/*   printf("%f\n", Rs.Y.lower); */
/*   printf("%f\n", Rs.Y.upper); */
/*   printf("%f\n", Rs.Z.lower); */
/*   printf("%f\n", Rs.Z.upper); */

/*   printf("structure: %s\n", printfun(tree)); */

/*   libfive_tree* t = malloc(sizeof(libfive_tree)); */
/*   t = tree; */

/*   /\* bool result; *\/ */
/*   /\* result = savefun(tree, R, res, f); *\/ */
/*   /\* printf("success? %b", result); *\/ */
/*   /\* result = savefun(tree, R, res, string_fix(f)); *\/ */
/*   /\* result = savefun(tree, R, res, str); *\/ */
/*   return savefun(t, Rs, res, f); */
/*   /\* return true; *\/ */
/*   //return true; */
/* } */

/* libfive_region3* to_region3(float xmin, float xmax, */
/*                             float ymin, float ymax, */
/*                             float zmin, float zmax)  */
/* { */
/*   libfive_interval* x = malloc(sizeof(libfive_interval)); */
/*   libfive_interval* y = malloc(sizeof(libfive_interval)); */
/*   libfive_interval* z = malloc(sizeof(libfive_interval)); */
/*   x->lower = xmin; */
/*   x->upper = xmax; */
/*   y->lower = ymin; */
/*   y->upper = ymax; */
/*   z->lower = zmin; */
/*   z->upper = zmax; */
  
/*   libfive_region3* r = malloc(sizeof(libfive_region3)); */
/*   r->X = *x; */
/*   r->Y = *y; */
/*   r->Z = *z; */

/*   /\* static libfive_region3 R; *\/ */
/*   /\* R = r; *\/ */

/*   //printf("region3:\n"); */
/*   //printf("%f\n", r.X.lower); */
/*   //printf("%f\n", r.X.upper); */
/*   //printf("%f\n", r.Y.lower); */
/*   //printf("%f\n", r.Y.upper); */
/*   //printf("%f\n", r.Z.lower); */
/*   //printf("%f\n", r.Z.upper); */

/*   return r; */
/* } */

/* bool libfive_tree_save_mesh_fix_full(const char* f, */
/*                                      libfive_tree* tree, */
/*                                      float xmin, float xmax, */
/*                                      float ymin, float ymax, */
/*                                      float zmin, float zmax, */
/*                                      float res, */
/*                                      save savefun) */
/* { */
/*   /\* libfive_region3 R; *\/ */
/*   libfive_region3* R = malloc(sizeof(libfive_region3)); */
/*   R = to_region3(xmin,xmax, */
/*                  ymin,ymax, */
/*                  zmin,xmax); */
/*   return libfive_tree_save_mesh_fix(tree,R,res,f,savefun); */
/* } */

/* bool libfive_tree_render_mesh_fixer(libfive_tree tree, */
/*                                     float xmin, float xmax, */
/*                                     float ymin, float ymax, */
/*                                     float zmin, float zmax, */
/*                                     float res, */
/*                                     save savefun) */
/* { */
/*   libfive_region3 R; */
/*   R = to_region3(xmin,xmax, */
/*                  ymin,ymax, */
/*                  zmin,xmax); */
/*   return libfive_tree_save_mesh_fix(f,tree,R,res,savefun); */
/* } */

/* float float_test(float x)  */
/* { */
/*   return x; */
/* } */

/* double double_test(double x)  */
/* { */
/*   return x; */
/* } */

/* float from_double(double x)  */
/* { */
/*   float y; */
/*   y = (float)x; */
/*   return nextafterf(y, INFINITY); */
/* } */

float from_int(int x) 
{
  float y;
  y = (float)x;
  return y;
}

/* int to_int(float x)  */
/* { */
/*   int y; */
/*   y = (float)x; */
/*   return y; */
/* } */

/* double to_double(float x)  */
/* { */
/*   double y; */
/*   y = (double)x; */
/*   return y; */
/* } */

/* double fdouble_test(double x)  */
/* { */
/*   float yt, y; double z; */
/*   yt = (float)x; */
/*   y = nextafterf(yt, INFINITY); */
/*   z = (double)y; */
/*   return z; */
/* } */

/* int fint_test(int x)  */
/* { */
/*   float y; int z; */
/*   y = (float)x; */
/*   z = (int)y; */
/*   return z; */
/* } */

/* #ifdef __cplusplus */
/* } // extern "C" */
/* #endif */
