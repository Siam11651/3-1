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
std::stringstream symbolTablePrinter;
bool newScope;

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
            newScope = true;
            SymbolInfo *symbolInfo = new SymbolInfo(yytext, "IF");

            symbolInfo->SetScopeID(st->GetCurrentScope()->GetID());
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

                return PRINTLN;
            }

"+"		|

"-"		{
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

"++"    {
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

"--"    {
            SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DECOP");

            symbolInfo->SetSymbolStart(lineCount);
            symbolInfo->SetSymbolEnd(lineCount);

            ParseTreeNode *parseTreeNode = new ParseTreeNode();

            parseTreeNode->name = "DECOP";
            parseTreeNode->terminal = true;
            parseTreeNode->startLine = lineCount;
            parseTreeNode->endLine = lineCount;
            parseTreeNode->symbolInfo = symbolInfo;

            yylval = parseTreeNode;

            return DECOP;
		}

"<"     |

"<="    |

">"     |

">="    |

"=="    |

"!="    {
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

"||"    |

"!"     {
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

"("     {
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

                                std::cerr << "Line " << lineCount << ": Too many decimal points" << std::endl;
                            }

{ILLFORMED_NUMBER}  {
                        ++errorCount;

                        std::cerr << "Line " << lineCount << ": Illformed number" << std::endl;
                    }

{INVALID_ID_SUFFIX_NUM_PREFIX}  {
                                    ++errorCount;

                                    std::cerr << "Line " << lineCount << ": Invalid identifier suffix" << std::endl;
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
        ++errorCount;

        std::cerr << "Line " << lineCount << ": Invalid character" << std::endl;
    }

%%