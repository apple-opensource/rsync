# generate prototypes for Samba C code
# tridge, June 1996

BEGIN {
  inheader=0;
  print "/* This file is automatically generated with \"make proto\". DO NOT EDIT */"
  print ""
}

{
  if (inheader) {
    if (match($0,"[)][ \t]*$")) {
      inheader = 0;
      printf "%s;\n",$0;
    } else {
      printf "%s\n",$0;
    }
    next;
  }
}

/^FN_LOCAL_BOOL/ {
  split($0,a,"[,()]")
  printf "BOOL %s(int );\n", a[2]
}

/^FN_LOCAL_STRING/ {
  split($0,a,"[,()]")
  printf "char *%s(int );\n", a[2]
}

/^FN_LOCAL_INT/ {
  split($0,a,"[,()]")
  printf "int %s(int );\n", a[2]
}

/^FN_LOCAL_CHAR/ {
  split($0,a,"[,()]")
  printf "char %s(int );\n", a[2]
}

/^FN_GLOBAL_BOOL/ {
  split($0,a,"[,()]")
  printf "BOOL %s(void);\n", a[2]
}

/^FN_GLOBAL_STRING/ {
  split($0,a,"[,()]")
  printf "char *%s(void);\n", a[2]
}

/^FN_GLOBAL_INT/ {
  split($0,a,"[,()]")
  printf "int %s(void);\n", a[2]
}

/^static|^extern/ || /[;]/ {
  next;
}

!/^[A-Za-z][A-Za-z0-9_]* / {
  next;
}

/[(].*[)][ \t]*$/ {
    printf "%s;\n",$0;
    next;
}

/[(]/ {
  inheader=1;
  printf "%s\n",$0;
  next;
}
