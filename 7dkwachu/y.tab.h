#define WYMIERNA 257
#define PLUS 258
#define MINUS 259
#define MNOZ 260
#define DZIEL 261
#define OTW 262
#define ZAM 263
#define FRACTION 264
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union {
struct {
	int licznik;
	int mianownik;
} fraction;
int integer;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
