%option noyywrap

%{
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include "1905039.tab.h"
#include "1905039_SymbolTable.h"
#include "1905039_ParseTreeNode.h"

using namespace std;

extern SymbolTable *st;
// FILE *yyin;
extern YYSTYPE yylval;
size_t lineCount = 1;
size_t errorCount = 0;
std::ofstream logStream;
std::stringstream symbolTablePrinter;

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
            st->EnterScope();

            logStream << "Line# " << lineCount << ": Token <IF> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo *symbolInfo = new SymbolInfo(yytext, "IF");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "IF";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return IF;
		}
		
"else"	{
			logStream << "Line# " << lineCount << ": Token <ELSE> Lexeme " << yytext << " found" << std::endl;   

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ELSE");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "ELSE";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return ELSE;
		}

"for"   {
            logStream << "Line# " << lineCount << ": Token <FOR> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "FOR");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "FOR";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return FOR;
        }

"while" {
            logStream << "Line# " << lineCount << ": Token <WHILE> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "WHILE");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "WHILE";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return WHILE;
        }

"do"    {
            logStream << "Line# " << lineCount << ": Token <DO> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DO");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "DO";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return DO;
        }

"break" {
            logStream << "Line# " << lineCount << ": Token <BREAK> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "BREAK");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "BREAK";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return BREAK;
        }

"int"   {
            logStream << "Line# " << lineCount << ": Token <INT> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "INT");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "INT";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return INT;
        }

"char"  {
            logStream << "Line# " << lineCount << ": Token <CHAR> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CHAR");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "CHAR";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return CHAR;
        }

"float" {
            logStream << "Line# " << lineCount << ": Token <FLOAT> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "FLOAT");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "FLOAT";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return FLOAT;
        }

"double"    {
                logStream << "Line# " << lineCount << ": Token <DOUBLE> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DOUBLE");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "DOUBLE";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return DOUBLE;
            }

"void"  {
            logStream << "Line# " << lineCount << ": Token <VOID> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "VOID");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "VOID";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return VOID;
        }

"return"    {
                logStream << "Line# " << lineCount << ": Token <RETURN> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RETURN");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "RETURN";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return RETURN;
            }

"switch"    {
                logStream << "Line# " << lineCount << ": Token <SWITCH> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "SWITCH");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "SWITCH";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return SWITCH;
            }

"case"  {
            logStream << "Line# " << lineCount << ": Token <CASE> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CASE");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "CASE";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return CASE;
        }

"default"   {
                logStream << "Line# " << lineCount << ": Token <DEFAULT> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DEFAULT");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "DEFAULT";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return DEFAULT;
            }

"continue"  {
                logStream << "Line# " << lineCount << ": Token <CONTINUE> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONTINUE");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "CONTINUE";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return CONTINUE;
            }

"println"   {
                logStream << "Line# " << lineCount << ": Token <PRINTLN> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "PRINTLN");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "PRINTLN";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return CONTINUE;
            }

"+"		|

"-"		{
			logStream << "Line# " << lineCount << ": Token <ADDOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ADDOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "ADDOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return ADDOP;
		}

"*"     |

"/"     |

"%"     {
			logStream << "Line# " << lineCount << ": Token <MULOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "MULOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "MULOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return MULOP;
		}

"++"    |

"--"    {
			logStream << "Line# " << lineCount << ": Token <INCOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "INCOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "INCOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return INCOP;
		}

"<"     |

"<="    |

">"     |

">="    |

"=="    |

"!="    {
			logStream << "Line# " << lineCount << ": Token <RELOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RELOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "RELOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return RELOP;
		}

"="     {
			logStream << "Line# " << lineCount << ": Token <ASSIGNOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ASSIGNOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "ASSIGNOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return ASSIGNOP;
		}

"&&"    |

"||"    {
			logStream << "Line# " << lineCount << ": Token <LOGICOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LOGICOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "LOGICOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return LOGICOP;
		}

"&"     |

"|"     |

"^"     |

"<<"    |

">>"    {
			logStream << "Line# " << lineCount << ": Token <BITOP> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "BITOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "BITOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return BITOP;
		}

"!"     {
			logStream << "Line# " << lineCount << ": Token <NOT> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "NOT");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "NOT";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return NOT;
		}

"("     {
			logStream << "Line# " << lineCount << ": Token <LPAREN> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LPAREN");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "LPAREN";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return LPAREN;
		}

")"     {
			logStream << "Line# " << lineCount << ": Token <RPAREN> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RPAREN");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "RPAREN";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return RPAREN;
		}

"{"     {
			logStream << "Line# " << lineCount << ": Token <LCURL> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LCURL");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "LCURL";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return LCURL;
		}

"}"     {
			logStream << "Line# " << lineCount << ": Token <RCURL> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RCURL");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "RCURL";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return RCURL;
		}

"["     {
			logStream << "Line# " << lineCount << ": Token <LSQUARE> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LSQUARE");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "LSQUARE";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return LSQUARE;
		}

"]"     {
			logStream << "Line# " << lineCount << ": Token <RSQUARE> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RSQUARE");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "RSQUARE";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return RSQUARE;
		}

","     {
			logStream << "Line# " << lineCount << ": Token <COMMA> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "COMMA");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "COMMA";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return COMMA;
		}

";"     {
			logStream << "Line# " << lineCount << ": Token <SEMICOLON> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "SEMICOLON");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "SEMICOLON";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return SEMICOLON;
		}
		
{INTEGER} 	{
				logStream << "Line# " << lineCount << ": Token <CONST_INT> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo *symbolInfo = new SymbolInfo(std::string(yytext), "CONST_INT");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "CONST_INT";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return CONST_INT;
			}

{FLOAT}     {
				logStream << "Line# " << lineCount << ": Token <CONST_FLOAT> Lexeme " << yytext << " found" << std::endl;

                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_FLOAT");

                symbolInfo->SetSymbolStart(lineCount);
                symbolInfo->SetSymbolEnd(lineCount);

                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                parseTreeNode->name = "CONST_FLOAT";
                parseTreeNode->terminal = true;
                parseTreeNode->startLine = lineCount;
                parseTreeNode->endLine = lineCount;
                parseTreeNode->symbolInfo = symbolInfo;

                yylval = parseTreeNode;

                return CONST_FLOAT;
			}

{CHAR_LITERAL}  {
                    std::string name = FormatLiteral(yytext);

                    logStream << "Line# " << lineCount << ": Token <CONST_CHAR> Lexeme " << name << " found" << std::endl;

                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_CHAR");

                    symbolInfo->SetSymbolStart(lineCount);
                    symbolInfo->SetSymbolEnd(lineCount);

                    ParseTreeNode *parseTreeNode = new ParseTreeNode();

                    parseTreeNode->name = "CONST_CHAR";
                    parseTreeNode->terminal = true;
                    parseTreeNode->startLine = lineCount;
                    parseTreeNode->endLine = lineCount;
                    parseTreeNode->symbolInfo = symbolInfo;

                    yylval = parseTreeNode;

                    return CONST_CHAR;
                }

{SINGLELINE_STRING_LITERAL} {
                                std::string yytextStr = std::string(yytext);
                                std::string name = FormatLiteral(yytext);

                                logStream << "Line# " << lineCount << ": Token <CONST_STRING> Lexeme " << name << " found" << std::endl;

                                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_STRING");

                                symbolInfo->SetSymbolStart(lineCount);
                                symbolInfo->SetSymbolEnd(lineCount);

                                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                                parseTreeNode->name = "CONST_STRING";
                                parseTreeNode->terminal = true;
                                parseTreeNode->startLine = lineCount;
                                parseTreeNode->endLine = lineCount;
                                parseTreeNode->symbolInfo = symbolInfo;

                                yylval = parseTreeNode;

                                return CONST_STRING;
                            }

{MULTILINE_STRING_LITERAL} {
                                std::string yytextStr = std::string(yytext);
                                std::string name = FormatLiteral(yytext);
                                
                                logStream << "Line# " << lineCount << ": Token <CONST_STRING> Lexeme " << name << " found" << std::endl;

                                SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_STRING");

                                symbolInfo->SetSymbolStart(lineCount);

                                for(size_t i = 0; i < yytextStr.size(); ++i)
                                {
                                    if(yytextStr[i] == '\n')
                                    {
                                        ++lineCount;
                                    }
                                }

                                symbolInfo->SetSymbolEnd(lineCount);

                                ParseTreeNode *parseTreeNode = new ParseTreeNode();

                                parseTreeNode->name = "CONST_STRING";
                                parseTreeNode->terminal = true;
                                parseTreeNode->startLine = lineCount;
                                parseTreeNode->endLine = lineCount;
                                parseTreeNode->symbolInfo = symbolInfo;

                                yylval = parseTreeNode;

                                return CONST_STRING;
                            }

{ID}    {
            logStream << "Line# " << lineCount << ": Token <ID> Lexeme " << yytext << " found" << std::endl;

            SymbolInfo* symbolInfo = new SymbolInfo(std::string(yytext), "ID");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "ID";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

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

                            for(size_t i = 0; i < comment.size(); ++i)
                            {
                                if(comment[i] == '\n')
                                {
                                    ++lineCount;
                                }
                            }
                        }

{TOO_MANY_DECIMAL_POINTS}   {
                                ++errorCount;
                            }

{ILLFORMED_NUMBER}  {
                        ++errorCount;
                    }

{INVALID_ID_SUFFIX_NUM_PREFIX}  {
                                    ++errorCount;
                                }

{UNFINISHED_CONST_CHAR} {
                            ++errorCount;
                        }

{MULTICHAR_CONST_CHAR}  {
                            ++errorCount;
                        }

{EMPTY_CONST_CHAR}  {
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

                            ++errorCount;
                        } 

.   {
        logStream << "Error at line# " << lineCount << ": UNRECOGNIZED CHAR " << yytext << std::endl;

        ++errorCount;
    }

%%