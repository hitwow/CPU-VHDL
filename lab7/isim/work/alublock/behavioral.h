////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_alublock_behavioral_H
#define H_Work_alublock_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_alublock_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[13];

  HSimArrayType Regbase;
  HSimArrayType Reg;
    HSim__s1 SA[8];
  char *t0;
    Work_alublock_behavioral(const char * name);
    ~Work_alublock_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_alublock_behavioral(const char *name);

#endif
