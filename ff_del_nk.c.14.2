/*
  This program deletes the entries in cookies.sqlite and webappsstore.sqlite
  in a firefox profile directory, except thooe belonging to a domain in a
  listed in a "keep" list.

  The profile directory name and keep list are "hard coded".

  A check is first made, whether the profile directory contains a lock file.
  It will do so if firefox is using the directory; see
   http://kb.mozillazine.org/Profile_in_use

  Also provided is a routine to dump the domain names.

  It is assumed that the domain name strings in webappsstore are in reverse
  order.  Also, any leading "www." is removed (this doesn't seem to be
  needed for cookies).

  This file compiles and executes correctly on Slackware 14.2.
  The compile command is "gcc -O2 -o ff_del_nk ff_del_nk.c -lsqlite3".
*/

#include <stdio.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include "errno.h"

#include <sqlite3.h>

/*profile directory*/
//#define PROFDIR "/home/martin/tmp/cookies/"
#define PROFDIR "/home/martin/.mozilla/firefox/w71zcoxo.default-1564523400780/"

/*table of domains to keep*/
#define NKDOMS 13
static const char *kdoms[NKDOMS]={
"amazon.com",
"aol.com",
"bankofamerica.com",
"ca.gov",
"doordash.com",
"grubhub.com",
"mathoverflow.net",
"medicare.gov",
"nextmd.com",
"researchgate.net",
"stackexchange.com",
"stackoverflow.com",
"sutterhealth.org",
};

/*subroutine to search kdoms*/
static int skdoms(const char *s)
{short x;
 for (x=0; x<NKDOMS; x++) if (strcmp(s,kdoms[x])==0) return x;
 return -1;
}

/*Dump domain names (0=cookies, 1=webappsstore)*/
static void dump_doms(int fx)
{sqlite3 *db;
 sqlite3_stmt *stmt;
 int rc;

 /*open test file*/
 if (fx==0)
  rc = sqlite3_open(PROFDIR"cookies.sqlite", &db);
 else
  rc = sqlite3_open(PROFDIR"webappsstore.sqlite", &db);
 if (rc != SQLITE_OK)
 {printf("ERROR opening DB: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*prepare SELECT statement*/
 rc = sqlite3_prepare_v2
 (db,
  fx==0?
   "SELECT baseDomain FROM moz_cookies":
   "SELECT originKey FROM webappsstore2",
  -1,
  &stmt,
  NULL);
 if (rc != SQLITE_OK)
 {printf("ERROR prpearing select stmt: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*step through rows*/
 {const char *pc;
 while ( (rc = sqlite3_step(stmt)) == SQLITE_ROW)
  if (fx==0)
  {printf("%s", pc=(const char *)sqlite3_column_text(stmt, 0) );
   if (skdoms(pc)>=0) putchar('*');
   putchar('\n');
  }
  else
  {char ori[256],*pe,*p1,*p2,c; unsigned short l;
   l=strlen(pc=(const char *)sqlite3_column_text(stmt, 0)); 
   if (l<256) memcpy(ori,pc,l+1);
   else {memcpy(ori,pc,255); ori[255]=0;}
   pe=strchr(ori,':'); pe--; *pe=0;
   p1=ori; p2=pe-1;
   while (p1<p2) {c=*p1; *p1=*p2; *p2=c; p1++; p2--;}
   fputs(ori,stdout);
   p1=memcmp(ori,"www.",4)?ori:ori+4;
   if (skdoms(p1)>=0) putchar('*');
   putchar('\n');
  }
 }

 sqlite3_finalize(stmt);
xit:
 sqlite3_close(db);
}

/*xFunc for dtst, fx=0*/
void cdtst
(sqlite3_context* context,
 int argc,
 sqlite3_value** argv
)
{const char *pc; unsigned rc;
 rc=0;
 pc=(const char *)sqlite3_value_text(argv[0]);
 if (skdoms(pc)<0) rc=1;
 sqlite3_result_int(context, rc);
}

/*xFunc for dtst, fx=1*/
void cdtst2
(sqlite3_context* context,
 int argc,
 sqlite3_value** argv
)
{const char *pc; unsigned l,rc;
 char ori[256],*pe,*p1,*p2,c;
 rc=0;
 l=strlen(pc=(const char *)sqlite3_value_text(argv[0]));
 if (l<256) memcpy(ori,pc,l+1);
 else {memcpy(ori,pc,255); ori[255]=0;}
 pe=strchr(ori,':'); pe--; *pe=0;
 p1=ori; p2=pe-1;
 while (p1<p2) {c=*p1; *p1=*p2; *p2=c; p1++; p2--;}
 p1=memcmp(ori,"www.",4)?ori:ori+4;
 if (skdoms(p1)<0) rc=1;
 sqlite3_result_int(context, rc);
}

/*Delete rows not in keep list*/
static void del_nk(int fx)
{sqlite3 *db;
 sqlite3_stmt *stmt;
 int rc;

 /*open test file*/
 if (fx==0)
  rc = sqlite3_open(PROFDIR"cookies.sqlite", &db);
 else
  rc = sqlite3_open(PROFDIR"webappsstore.sqlite", &db);
 if (rc != SQLITE_OK)
 {printf("ERROR opening DB: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*create testing function; see
   https://www.sqlite.org/appfunc.html
   https://www.sqlite.org/c3ref/create_function.html
   Only xFunc is specified;
    this seems to work, i.e., it's called for every row.
 */
 rc= sqlite3_create_function
 (db,                  /*database*/
  "dtst",              /*SQL name*/
  1,                   /*number of arguments*/
  SQLITE_UTF8,         /*text encoding*/
  NULL,                /*pointer*/
  fx==0?cdtst:cdtst2,               /*implementing function*/
  NULL,
  NULL
 );
 if (rc != SQLITE_OK)
 {printf("ERROR creating function: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*prepare DELETE statement*/
 rc = sqlite3_prepare_v2
 (db,
  fx==0?
   "DELETE FROM moz_cookies WHERE dtst(baseDomain)":
   "DELETE FROM webappsstore2 WHERE dtst(originKey)",
  -1,
  &stmt,
  NULL);
 if (rc != SQLITE_OK)
 {printf("ERROR preparing delete stmt: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*execute delete command*/
 rc = sqlite3_step(stmt);
 if (rc != SQLITE_DONE)
 {printf("ERROR executing delete stmt: %s\n",sqlite3_errmsg(db));
  goto xit;
 }

 /*finalize DELETE command*/
 sqlite3_finalize(stmt);

 /*issue VACUUM command*/
 rc = sqlite3_prepare_v2
 (db, "VACUUM", -1, &stmt, NULL);
 if (rc != SQLITE_OK)
 {printf("ERROR preparing vacuum stmt: %s\n",sqlite3_errmsg(db));
  goto xit;
 }
 rc = sqlite3_step(stmt);
 if (rc != SQLITE_DONE)
 {printf("ERROR executing vacuum stmt: %s\n",sqlite3_errmsg(db));
  goto xit;
 }
 sqlite3_finalize(stmt);

 /*Note:
   VACUUM will generally reduce the file siae.
   REINDEX could be done also; this might improve performance.
 */

xit:
 sqlite3_close(db);
}

int main(void)
{

/*Check if symbolic link "lock" exists.
  If so, it should have a non-file target.
*/
 {struct stat stbuf;
  if (lstat(PROFDIR"lock",&stbuf)==0)
  {puts("Profile directory containes a lock file; exiting");
   return 0;
  }
 }

 del_nk(0);
 del_nk(1);

 return 0;
}
