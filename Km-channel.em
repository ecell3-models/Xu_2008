  #  Km channel (Ca-independent k channel)
  #  From Migliore et al. 1995. J Neurophysiology
  #  km()


  Variable Variable( km_q10 )
  { Value  @( pow( 5.0,( (7)/10 ) ) );
  }
  Variable Variable( km_am )
  { Value 0; #tmp
  }
  Variable Variable( km_bm )
  { Value 0; #tmp
  }
  Variable Variable( km_tau_m )
  { Value 0; #tmp
  }
  Variable Variable( km_m_inf )
  { Value 0; #tmp
  }


  Process ExpressionAssignmentProcess ( km_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess( km_am )
  {
    StepperID  Default;
    #Expression  "km_q10.Value*0.006*exp(1.e-3*10*0.06*(v.Value+55)*F.Value/(R.Value*T.Value))";
    Expression  "km_q10.Value*0.006*exp(0.001*10*0.06*(v.Value+55)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ km_am :/:km_am 1 ]
      [ km_q10 :/:km_q10 0 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( km_bm )
  {
    StepperID  Default;
    #Expression  "km_q10.Value*0.006*exp(-1.e-3*9.4*(v.Value+55)*F.Value/(R.Value*T.Value))";
    Expression  "km_q10.Value*0.006*exp(-0.001*9.4*(v.Value+55)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ km_bm :/:km_bm 1 ]
      [ km_q10 :/:km_q10 0 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( km_tau_m )
  {
    StepperID  Default;
    Expression  "1/(km_am.Value+km_bm.Value)";
    VariableReferenceList
      [ km_tau_m :/:km_tau_m 1 ]
      [ km_am :/:km_am 0 ]
      [ km_bm :/:km_bm 0 ];
  }
  Process ExpressionAssignmentProcess( km_m_inf )
  {
    StepperID  Default;
    Expression  "km_am.Value*km_tau_m.Value";
    VariableReferenceList
      [ km_m_inf :/:km_m_inf 1 ]
      [ km_am :/:km_am 0 ]
      [ km_tau_m :/:km_tau_m 0 ];
  }


  Process ExpressionFluxProcess( km_mkm )
  {
    StepperID  Default;
    Expression  "( km_m_inf.Value/km_tau_m.Value ) / ( 1/km_tau_m.Value )";
    VariableReferenceList
      [ mkm :/:mkm 1 ]
      [ km_m_inf :/:km_m_inf 0 ]
      [ km_tau_m :/:km_tau_m 0 ];
  }
  Process ExpressionAssignmentProcess( km_ikm )
  {
    StepperID  Default;
    Expression  "gkm.Value*mkm.Value*(v.Value+91.0)";
    VariableReferenceList
      [ ikm :/:ikm 1 ]
      [ gkm :/:gkm 0 ]
      [ mkm :/:mkm 0 ]
      [ v :/:v 0 ];
  }


