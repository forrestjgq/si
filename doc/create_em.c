#include "stdio.h"
#include "stdlib.h"
#include "assert.h"
#include "list.h"
#include "string.h"
#define SZ_OF_MEMBER(type, member) sizeof((((type) *)0)->member)

typedef struct
{
    char *str;
    u16 key;
    u8 bControl;
    u8 bch;
} CharDef;

//#define USE_LOWER_CASE

#ifdef USE_LOWER_CASE
#else
#define TRANS(ch) (((ch) >= 'a' && (ch) <= 'z') ? ((ch) - 'a' + 'A') : (ch)) 
#define TRANSTO(ch) (((ch) >= 'a' && (ch) <= 'z') ? ((ch) - 'a' + 'A') : (ch)) 
#endif /* USE_LOWER_CASE */

#define UPPER(ch) (((ch) >= 'a' && (ch) <= 'z') ? ((ch) - 'a' + 'A') : (ch)) 
#define LOWER(ch) (((ch) >= 'A' && (ch) <= 'Z') ? ((ch) - 'A' + 'a') : (ch)) 


#define ISCH(ch)   (((ch) >= 'A' && (ch) <= 'Z') || ((ch) >= 'a' && (ch) <= 'z'))
CharDef spec[] =
{
    {"CTRL",        0x0400, 1, 0},
    {"ALT",         0x0800, 1, 0},
    {"SHIFT",       0x0300, 1, 0},
    {"Ins",         32813, 0, 0},
    {"Enter",       13, 0, 0},
    {"Tab",         9, 0, 0},
    {"BackSpace",   8, 0, 0},
    {"End",         32803, 0, 0},
    {"Home",        32804, 0, 0},
    {"Down",        32808, 0, 0},
    {"Up",          32806, 0, 0},
    {"Left",        32805, 0, 0},
    {"Right",       32807, 0, 0},
    {"F1",          4208, 0, 0},
    {"F2",          4209, 0, 0},
    {"F3",          4210, 0, 0},
    {"F4",          4211, 0, 0},
    {"F5",          4212, 0, 0},
    {"F6",          4213, 0, 0},
    {"F7",          4214, 0, 0},
    {"F8",          4215, 0, 0},
    {"F9",          4216, 0, 0},
    {"F10",         4217, 0, 0},
    {"F11",         4218, 0, 0},
    {"F12",         4219, 0, 0},
};  

char *extcmd="EXCMPN";
typedef enum
{
    E_EDIT,
    X_BUFF,
    C_CMT,
    M_WND,
    P_PROJ,
    N_NAVI,

    MAX_EXT
}ExtCmd;

#define SZSPEC (sizeof(spec) / sizeof(spec[0]))
#define PTK printf
#define PTK1(fmt, ...) PTK("    "fmt, ##__VA_ARGS__)
#define OUT_EXT ".em"
#define BUFLEN 1024
char buf[BUFLEN];

typedef struct {
    struct list_head node;
    char *func;
    u16 key; 
    u16 key1;
    char *keystr;
    char *cmd;
}Assign;

struct list_head cmdhdr;
struct list_head extHdr[MAX_EXT];

CharDef normal;

#define M_INSTALL "eInstall"
char *M_EXT_STR[MAX_EXT] =
{
    "eEditCmd",
    "eBufCmd",
    "eCmtCmd",
    "eWndCmd",
    "ePrjCmd",
    "eNaviCmd"
};

#ifdef WIN32
#define STRICMP stricmp 
#else
#define STRICMP strcasecmp 
#endif
CharDef *match_spec(char *str)
{
    u8 i = 0;
    int len = strlen(str);
    if(len == 0)
    {
        normal.str[0] = '+';
        normal.key = '+';
        normal.bch = 0;
        return &normal;
    }
    
    if(strlen(str) == 1)
    {
        normal.str[0] = UPPER(str[0]);
        normal.key = UPPER(str[0]);
        normal.bch = ISCH(str[0]);
        return &normal;
    }
    
    for(i = 0; i < SZSPEC; i++)
    {
        if(STRICMP(spec[i].str, str) == 0)
        {
            return &spec[i];
        }
    }

    PTK1("Key %s not found\n", str);
    return NULL;
}

char plus[2];
void proc(char *str)
{
    u8 bPlus = 0;
    Assign *as = (Assign*)malloc(sizeof(Assign));
    memset(as, 0, sizeof(Assign));
    as->keystr = strdup(str);

    int len = strlen(str);
    if(len > 1 && str[len-1] == '+')
    {
        bPlus = 1;
    }
    
    PTK("Process %s:\n", str);
    char *cmd = strtok(str, " ");
    if(!cmd)
    {
        PTK1("cmd not found\n");
        goto CLEAN;
    }
    
    as->cmd = strdup(cmd);
    char *p = cmd;
    while(*p != 0)
    {
        if(*p == '_') *p = ' ';
        p++;
    }

    as->func = strdup(cmd);
    PTK1("Func(%s) Cmd(%s)\n", as->func, as->cmd);

    u8 bControl = 1;
    u8 bFirst = 1;
    ExtCmd ext = MAX_EXT;

    
    while((p = strtok(NULL, "+")) != NULL || bPlus)
    {
        if(!p && bPlus) 
        {
            bPlus = 0;
            p = plus;
        }
        PTK1("Get Key %s\n", p);
        if(bFirst)
        {
            bFirst = 0;
            if(strlen(p) == 1)
            {
                char *px = extcmd;
                while(*px != 0)
                {
                    if(*px == p[0])
                    {
                        ext = px - extcmd;
                    }
                    px++;
                } 
                if(ext == MAX_EXT)
                {
                    PTK1("Invliad ext cmd %s\n", p); 
                    goto CLEAN;;
                }
                continue;
            }
        }
        
        CharDef *r = match_spec(p);
        if(!r)
        {
            PTK1("No match for %s\n", p);
            goto CLEAN;
        }

        if(!bControl && r->bControl)
        {
            PTK1("Control after not control\n");
            goto CLEAN;
        }

        bControl = r->bControl;
        as->key += r->key;
        as->key1+= r->key;
        if(r->bch)
        {
            as->key1 += 32;
        }
    }

    if(bControl)
    {
        PTK1("No not control\n");
        goto CLEAN;
    }

    if(ext >= MAX_EXT)
        list_add_tail(&as->node, &cmdhdr);
    else
        list_add_tail(&as->node, &extHdr[ext]);

    return;
CLEAN:
    PTK("Error occur\n");
    assert(0);
    if(as->func) free(as->func);
    if(as->cmd) free(as->cmd);
    if(as->keystr) free(as->keystr);
    free(as);
    return;
    
}
void init(void)
{
    normal.str = (char *)malloc(2);
    memset(normal.str, 0, 2);
    normal.key = 0;
    normal.bControl = 0;

    INIT_LIST_HEAD(&cmdhdr);
    int i;
    for(i = 0; i < MAX_EXT; i++)
    {
        INIT_LIST_HEAD(&extHdr[i]);
    }

    plus[0] = '+';
    plus[1] = 0;
}
//#define DEBUGEM
void install(FILE *f)
{
    Assign *p;

    PTK("Start install\n"); 
    
    assert(!list_empty(&cmdhdr));
    fprintf(f, "macro %s ()\n{\n", M_INSTALL);
    list_for_each_entry(p, &cmdhdr, node)
    {
        PTK1("install: %s\n", p->keystr);
        fprintf(f, "\t/* %s */\n", p->keystr);
        fprintf(f, "\tAssignKeyToCmd(%u, \"%s\")\n\n", p->key, p->func);
    }
    fprintf(f, "}\n");

    
    int i;
    for(i = 0; i < MAX_EXT; i++)
    {
        fprintf(f, "macro %s ()\n{\n", M_EXT_STR[i]);
        fprintf(f, "\tvar key\n", M_EXT_STR[i]);
        fprintf(f, "\tkey = _InputKey()\n\n", M_EXT_STR[i]);
        
        if(list_empty(&extHdr[i]))
        {
            PTK("%s list empty\n", M_EXT_STR[i]);
        }
        
        list_for_each_entry(p, &extHdr[i], node)
        {
            PTK1("install: %s\n", p->keystr);
            fprintf(f, "\t/* %s */\n", p->keystr);
            if(p->key != p->key1)
                fprintf(f, "\tif(key == %u || key == %u) {\n", p->key, p->key1);
            else
                fprintf(f, "\tif(key == %u) {\n", p->key);
#ifdef DEBUGEM
            fprintf(f, "\t\tmsg(\"%s\")\n", p->cmd);
#endif  
            fprintf(f, "\t\t%s\n", p->cmd);
            fprintf(f, "\t\tstop\n");
            fprintf(f, "\t}\n\n"); 
        }
        
        fprintf(f, "}\n");
    }
}
int main(int argc, char *argv[])
{
    int ret = 0;
    if(argc != 2)
    {
        PTK("Cmd Key File must be provided\n");
        return 1;
    }
    FILE *fin = fopen(argv[1], "r");
    if(!fin)
    {
        PTK("File %s can not be opened\n", argv[1]);
        return 1;
    }
    
    int len = strlen(argv[1]) + strlen(OUT_EXT) + 1;
    char *ofn = (char *)malloc(len);
    memset(ofn, 0, len);
    strcpy(ofn, argv[1]);
    strcat(ofn, OUT_EXT);
    
    FILE *fout = fopen(ofn, "w");
    if(!fout)
    {
        PTK("File %s can not be opened\n", ofn);
        ret = 2;
        goto CLEANUP;
    }

    init();
    
    while(!feof(fin))
    {
        memset(buf, 0, sizeof(buf));
        fgets(buf, BUFLEN-1, fin);
        if(!ISCH(buf[0]))
        {
            PTK("Ignore %s\n", buf);
            continue;
        }
        len = strlen(buf);
        if(len > 1 && buf[len-1] == '\n')
        {
            buf[len-1] = 0;
        }
        proc(buf);
    }

    install(fout);

    PTK("Size %u\n", SZ_OF_MEMBER(Assign, key);
CLEANUP:
    if(fin) fclose(fin);
    if(fout) fclose(fout);

    return ret;
}


