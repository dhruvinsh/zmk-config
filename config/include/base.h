// some easy key equivalency
#define XXX &none
#define ___ &trans
#define KEYS_L                                                                 \
  LT0 LT1 LT2 LT3 LT4 LM0 LM1 LM2 LM3 LM4 LB0 LB1 LB2 LB3 LB4 // left hand
#define KEYS_R                                                                 \
  RT0 RT1 RT2 RT3 RT4 RM0 RM1 RM2 RM3 RM4 RB0 RB1 RB2 RB3 RB4 // right hand

#if defined LH2
#define THUMBS LH2 LH1 LH0 RH0 RH1 RH2 // thumbs on 36 keys
#else
#define THUMBS LH1 LH0 RH0 RH1 // thumbs on 34 keys
#endif
