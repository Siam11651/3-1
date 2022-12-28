%option noyywrap

%{
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include "y.tab.h"
#include "1905039_SymbolTable.h"

using namespace std;

extern YYSTYPE yylval;
size_t lineCount = 1;
size_t errorCount = 0;
FILE *logout;
FILE *tokenout;
std::stringstream symbolTablePrinter;
SymbolTable st(10, &symbolTablePrinter);

std::string FormatLiteral(const std::string yytext)
{
    std::string yytextStr = string(yytext);
    std::string name = "";
    char prev = 0;

    for(size_t i = 1; i < yytextStr.size() - 1; ++i)
    {
        if(prev == '\\')
        {
            prev = yytextStr[i];

            if(yytextStr[i] == '\'')
            {
                name += '\'';
            }
            else if(yytextStr[i] == '\"')
            {
                name += '\"';
            }
            else if(yytextStr[i] == 'n')
            {
                name += '\n';
            }
            else if(yytextStr[i] == 't')
            {
                name += '\t';
            }
            else if(yytextStr[i] == '\\')
            {
                name += '\\';
                prev = 0;
            }
            else if(yytextStr[i] == 'a')
            {
                name += '\a';
            }
            else if(yytextStr[i] == 'f')
            {
                name += '\f';
            }
            else if(yytextStr[i] == 'r')
            {
                name += '\r';
            }
            else if(yytextStr[i] == 'b')
            {
                name += '\b';
            }
            else if(yytextStr[i] == 'v')
            {
                name += '\v';
            }
            else if(yytextStr[i] == '0')
            {
                name += '\0';
            }
            else if(yytextStr[i] == '\r')
            {
                prev = '\\';
            }
            else if(yytextStr[i] == '\n')
            {
                
            }
        }
        else
        {
            prev = yytextStr[i];

            if(yytextStr[i] != '\\')
            {
                name += yytextStr[i];
            }
        }
    }

    return name;
}
%}

WHITESPACE [ \t\f\r\v]
WHITESPACES {WHITESPACE}+
NEWLINE \n
DELIM ({NEWLINE}|{WHITESPACE})
LETTER [a-zA-Z]
DIGIT [0-9]
CHAR ([^\\\'\"\r\n]|\\n|\\t|\\\"|\\\'|\\\\|\\a|\\f|\\r|\\b|\\v|\\0|\\[\r]?\n)
CHARS {CHAR}+
CHAR_LITERAL \'{CHAR}\'
INTEGER {DIGIT}+
FLOAT ({DIGIT}*\.{DIGIT}+([Ee][+-]?{DIGIT}+)?|{DIGIT}+\.?[Ee][+-]?{DIGIT}+)
SINGLELINE_STRING_LITERAL \"([^\\\'\"\n\r]|\\n|\\t|\\\"|\\\'|\\\\|\\a|\\f|\\r|\\b|\\v|\\0)*\"
MULTILINE_STRING_LITERAL \"([^\\\'\"\n\r]|\\n|\\t|\\\"|\\\'|\\\\|\\a|\\f|\\r|\\b|\\v|\\0|\\[\r]?\n)*\"
SINGLE_LINE_COMMENT \/\/[^\r\n]*
MULTILINE_COMMENT_1 \/\/([^\r\n]*\\[\r]?\n)*[^\r\n]*
MULTILINE_COMMENT_2 \/\*([^\*]|\*[^\/])*\*\/
ID ({LETTER}|_)({LETTER}|{DIGIT}|_)*
TOO_MANY_DECIMAL_POINTS {DIGIT}*\.{DIGIT}+(\.{DIGIT}+)+([Ee][+-]?{DIGIT}+)?
ILLFORMED_NUMBER ({DIGIT}*\.{DIGIT}+[Ee][+-]?{DIGIT}+(\.{DIGIT}+)+|{DIGIT}+\.?[Ee][+-]?{DIGIT}+(\.{DIGIT}+)+)
INVALID_ID_SUFFIX_NUM_PREFIX ({FLOAT}|{INTEGER}){ID}
MULTICHAR_CONST_CHAR \'{CHAR}{CHAR}+\'
EMPTY_CONST_CHAR \'\'
UNFINISHED_CONST_CHAR \'{CHAR}?
UNFINISHED_STRING \"([^\\\'\"\n\r]|\\n|\\t|\\\"|\\\'|\\\\|\\a|\\f|\\r|\\b|\\v|\\0|\\[\r]?\n)*
UNFINISHED_COMMENT \/\*([^\*]|\*[^\/])*

%%

{NEWLINE}   {
                lineCount++;
            }

{WHITESPACES}   {
                    
                }

"if"	{
			fprintf(tokenout, "<IF, if>\n");
			fprintf(logout, "Line# %d: Token <IF> Lexeme %s found\n", lineCount, yytext);

            return IF;
		}
		
"else"	{
			fprintf(tokenout, "<ELSE, else>\n");
			fprintf(logout, "Line# %d: Token <ELSE> Lexeme %s found\n", lineCount, yytext);

            return ELSE;
		}

"for"   {
            fprintf(tokenout, "<FOR, for>\n");
			fprintf(logout, "Line# %d: Token <FOR> Lexeme %s found\n", lineCount, yytext);

            return FOR;
        }

"while" {
            fprintf(tokenout, "<WHILE, while>\n");
			fprintf(logout, "Line# %d: Token <WHILE> Lexeme %s found\n", lineCount, yytext);

            return WHILE;
        }

"do"    {
            fprintf(tokenout, "<DO, do>\n");
			fprintf(logout, "Line# %d: Token <DO> Lexeme %s found\n", lineCount, yytext);

            return DO;
        }

"break" {
            fprintf(tokenout, "<BREAK, break>\n");
			fprintf(logout, "Line# %d: Token <BREAK> Lexeme %s found\n", lineCount, yytext);

            return BREAK;
        }

"int"   {
            fprintf(tokenout, "<INT, int>\n");
			fprintf(logout, "Line# %d: Token <INT> Lexeme %s found\n", lineCount, yytext);

            return INT;
        }

"char"  {
            fprintf(tokenout, "<CHAR, char>\n");
			fprintf(logout, "Line# %d: Token <CHAR> Lexeme %s found\n", lineCount, yytext);

            return CHAR;
        }

"float" {
            fprintf(tokenout, "<FLOAT, float>\n");
			fprintf(logout, "Line# %d: Token <FLOAT> Lexeme %s found\n", lineCount, yytext);

            return FLOAT;
        }

"double"    {
                fprintf(tokenout, "<DOUBLE, double>\n");
                fprintf(logout, "Line# %d: Token <DOUBLE> Lexeme %s found\n", lineCount, yytext);

                return DOUBLE;
            }

"void"  {
            fprintf(tokenout, "<VOID, void>\n");
			fprintf(logout, "Line# %d: Token <VOID> Lexeme %s found\n", lineCount, yytext);

            return VOID;
        }

"return"    {
                fprintf(tokenout, "<RETURN, return>\n");
                fprintf(logout, "Line# %d: Token <RETURN> Lexeme %s found\n", lineCount, yytext);

                return RETURN;
            }

"switch"    {
                fprintf(tokenout, "<SWITCH, switch>\n");
                fprintf(logout, "Line# %d: Token <SWITCH> Lexeme %s found\n", lineCount, yytext);

                return SWITCH;
            }

"case"  {
            fprintf(tokenout, "<CASE, case>\n");
			fprintf(logout, "Line# %d: Token <CASE> Lexeme %s found\n", lineCount, yytext);

            return CASE;
        }

"default"   {
                fprintf(tokenout, "<DEFAULT, default>\n");
                fprintf(logout, "Line# %d: Token <DEFAULT> Lexeme %s found\n", lineCount, yytext);

                return DEFAULT;
            }

"continue"  {
                fprintf(tokenout, "<CONTINUE, continue>\n");
                fprintf(logout, "Line# %d: Token <CONTINUE> Lexeme %s found\n", lineCount, yytext);

                return CONTINUE;
            }

"+"		|

"-"		{
			fprintf(tokenout, "<ADDOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <ADDOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ADDOP");
            yylval = (YYSTYPE)symbolInfo;

            return ADDOP;
		}

"*"     |

"/"     |

"%"     {
			fprintf(tokenout, "<MULOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <MULOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "MULOP");
            yylval = (YYSTYPE)symbolInfo;

            return MULOP;
		}

"++"    |

"--"    {
			fprintf(tokenout, "<INCOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <INCOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "INCOP");
            yylval = (YYSTYPE)symbolInfo;

            return INCOP;
		}

"<"     |

"<="    |

">"     |

">="    |

"=="    |

"!="    {
			fprintf(tokenout, "<RELOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <RELOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RELOP");
            yylval = (YYSTYPE)symbolInfo;

            return RELOP;
		}

"="     {
			fprintf(tokenout, "<ASSIGNOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <ASSIGNOP> Lexeme %s found\n", lineCount, yytext);

            return ASSIGNOP;
		}

"&&"    |

"||"    {
			fprintf(tokenout, "<LOGICOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <LOGICOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LOGICOP");
            yylval = (YYSTYPE)symbolInfo;

            return LOGICOP;
		}

"&"     |

"|"     |

"^"     |

"<<"    |

">>"    {
			fprintf(tokenout, "<BITOP, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <BITOP> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "BITOP");
            yylval = (YYSTYPE)symbolInfo;

            return BITOP;
		}

"!"     {
			fprintf(tokenout, "<NOT, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <NOT> Lexeme %s found\n", lineCount, yytext);

            return NOT;
		}

"("     {
			fprintf(tokenout, "<LPAREN, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <LPAREN> Lexeme %s found\n", lineCount, yytext);

            return LPAREN;
		}

")"     {
			fprintf(tokenout, "<RPAREN, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <RPAREN> Lexeme %s found\n", lineCount, yytext);

            return RPAREN;
		}

"{"     {
            st.EnterScope();
			fprintf(tokenout, "<LCURL, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <LCURL> Lexeme %s found\n", lineCount, yytext);

            return LCURL;
		}

"}"     {
            st.ExitScope();
			fprintf(tokenout, "<RCURL, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <RCURL> Lexeme %s found\n", lineCount, yytext);

            return RCURL;
		}

"["     {
			fprintf(tokenout, "<LSQUARE, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <LSQUARE> Lexeme %s found\n", lineCount, yytext);

            return LSQUARE;
		}

"]"     {
			fprintf(tokenout, "<RSQUARE, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <RSQUARE> Lexeme %s found\n", lineCount, yytext);

            return RSQUARE;
		}

","     {
			fprintf(tokenout, "<COMMA, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <COMMA> Lexeme %s found\n", lineCount, yytext);

            return COMMA;
		}

";"     {
			fprintf(tokenout, "<SEMICOLON, %s>\n", yytext);
			fprintf(logout, "Line# %d: Token <SEMICOLON> Lexeme %s found\n", lineCount, yytext);

            return SEMICOLON;
		}
		
{INTEGER} 	{
				fprintf(tokenout, "<CONST_INT, %s>\n", yytext);
				fprintf(logout, "Line# %d: Token <CONST_INT> Lexeme %s found\n", lineCount, yytext);
				//insert in symbol table and print symbol table content(only non empty buckets)

                SymbolInfo *symbolInfo = new SymbolInfo(std::string(yytext), "CONST_INT");
                yylval = (YYSTYPE)symbolInfo;

                return CONST_INT;
			}

{FLOAT}     {
				fprintf(tokenout, "<CONST_FLOAT, %s>\n", yytext);
				fprintf(logout, "Line# %d: Token <CONST_FLOAT> Lexeme %s found\n",lineCount,yytext);

                return CONST_FLOAT;
			}

{CHAR_LITERAL}  {
                    std::string name = FormatLiteral(yytext);

                    fprintf(tokenout, "<CONST_CHAR, %s>\n", name.c_str());
                    fprintf(logout, "Line# %d: Token <CONST_CHAR> Lexeme %s found\n", lineCount, name.c_str());

                    SymbolInfo* symbolInfo = new SymbolInfo(name, "CONST_CHAR");

                    return CONST_CHAR;
                }

{SINGLELINE_STRING_LITERAL} {
                                std::string yytextStr = std::string(yytext);
                                std::string name = FormatLiteral(yytext);

                                fprintf(tokenout, "<SINGLE LINE STRING, %s>\n", name.c_str());
                                fprintf(logout, "Line# %d: Token <SINGLE LINE STRING> Lexeme %s found\n", lineCount, yytextStr.c_str());

                                SymbolInfo* symbolInfo = new SymbolInfo(name, "CONST_STRING");
                                yylval = (YYSTYPE)symbolInfo;

                                return CONST_STRING;
                            }

{MULTILINE_STRING_LITERAL} {
                                std::string yytextStr = std::string(yytext);
                                std::string name = FormatLiteral(yytext);
                                
                                fprintf(tokenout, "<MULTI LINE STRING, %s>\n", name.c_str());
                                fprintf(logout, "Line# %d: Token <MULTI LINE STRING> Lexeme %s found\n", lineCount, yytextStr.c_str());

                                for(size_t i = 0; i < yytextStr.size(); ++i)
                                {
                                    if(yytextStr[i] == '\n')
                                    {
                                        ++lineCount;
                                    }
                                }

                                SymbolInfo* symbolInfo = new SymbolInfo(name, "CONST_STRING");
                                yylval = (YYSTYPE)symbolInfo;

                                return CONST_STRING;
                            }

{ID}    {
            fprintf(tokenout, "<ID, %s>\n", yytext);
            fprintf(logout, "Line# %d: Token <ID> Lexeme %s found\n", lineCount, yytext);

            SymbolInfo* symbolInfo = new SymbolInfo(std::string(yytext), "ID");
            yylval = (YYSTYPE)symbolInfo;

            return ID;
        }

{SINGLE_LINE_COMMENT}   {
                            std::string name = yytext;

                            if(name.back() == '\n')
                            {
                                name.pop_back();
                            }

                            if(name.back() == '\r')
                            {
                                name.pop_back();
                            }

                            fprintf(logout, "Line# %d: Token <SINGLE LINE COMMENT> Lexeme %s found\n", lineCount, name.c_str());

                            // ++lineCount;
                        }

{MULTILINE_COMMENT_1}   {
                            std::string comment = yytext;
                            size_t add = 0;

                            if(comment.back() == '\n')
                            {
                                ++add;

                                comment.pop_back();
                            }

                            if(comment.back() == '\r')
                            {
                                comment.pop_back();
                            }

                            fprintf(logout, "Line# %d: Token <SINGLE LINE COMMENT> Lexeme %s found\n", lineCount, comment.c_str());

                            lineCount += add;

                            for(size_t i = 0; i < comment.size(); ++i)
                            {
                                if(comment[i] == '\n')
                                {
                                    ++lineCount;
                                }
                            }
                        }

{MULTILINE_COMMENT_2}   {
                            std::string comment = yytext;

                            fprintf(logout, "Line# %d: Token <MULTI LINE COMMENT> Lexeme %s found\n", lineCount, comment.c_str());

                            for(size_t i = 0; i < comment.size(); ++i)
                            {
                                if(comment[i] == '\n')
                                {
                                    ++lineCount;
                                }
                            }
                        }

{TOO_MANY_DECIMAL_POINTS}   {
                                fprintf(logout, "Error at line# %d: TOO_MANY_DECIMAL_POINTS %s\n", lineCount, yytext);

                                ++errorCount;
                            }

{ILLFORMED_NUMBER}  {
                        fprintf(logout, "Error at line# %d: ILLFORMED_NUMBER %s\n", lineCount, yytext);

                        ++errorCount;
                    }

{INVALID_ID_SUFFIX_NUM_PREFIX}  {
                                    fprintf(logout, "Error at line# %d: INVALID_ID_SUFFIX_NUM_PREFIX %s\n", lineCount, yytext);

                                    ++errorCount;
                                }

{UNFINISHED_CONST_CHAR} {
                            fprintf(logout, "Error at line# %d: UNFINISHED_CONST_CHAR %s\n", lineCount, yytext);

                            ++errorCount;
                        }

{MULTICHAR_CONST_CHAR}  {
                            fprintf(logout, "Error at line# %d: MULTICHAR_CONST_CHAR %s\n", lineCount, yytext);

                            ++errorCount;
                        }

{EMPTY_CONST_CHAR}  {
                        fprintf(logout, "Error at line# %d: EMPTY_CONST_CHAR %s\n", lineCount, yytext);

                        ++errorCount;
                    }

{UNFINISHED_STRING} {
                        std::string yytextStr = yytext;

                        for(size_t i = 0; i < yytextStr.size(); ++i)
                        {
                            if(yytextStr[i] == '\n')
                            {
                                ++lineCount;
                            }
                        }

                        fprintf(logout, "Error at line# %d: UNFINISHED_STRING %s\n", lineCount, yytext);

                        ++errorCount;
                    }
                    
{UNFINISHED_COMMENT}    {
                            std::string yytextStr = yytext;

                            for(size_t i = 0; i < yytextStr.size(); ++i)
                            {
                                if(yytextStr[i] == '\n')
                                {
                                    ++lineCount;
                                }
                            }

                            while(yytextStr.back() == '\r' || yytextStr.back() == '\n')
                            {
                                yytextStr.pop_back();
                            }

                            fprintf(logout, "Error at line# %d: UNFINISHED_COMMENT %s\n", lineCount, yytextStr.c_str());

                            ++errorCount;
                        } 

.   {
        fprintf(logout, "Error at line# %d: UNRECOGNIZED_CHAR %s\n", lineCount, yytext);

        ++errorCount;
    }

%%

int yywrap(void)
{
	return 1;
}