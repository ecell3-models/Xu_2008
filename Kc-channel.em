
  #  Kc channel (Ca-dependent k channel)
  #  From Migliore et al. 1995. J Neurophysiology
  #  Based on data by Moczydlowski & Latorre, J Gen Physiol. 1983, 82:511-542 
  #  kc()


  Variable Variable( kc_ao )
  { Value 0; #tmp
  }
  Variable Variable( kc_bo )
  { Value 0; #tmp
  }
  Variable Variable( kc_tau_o )
  { Value 0; #tmp
  }
  Variable Variable( kc_o_inf )
  { Value 0; #tmp
  }


  Variable Variable( kc_k1 )
  { Value 0.48e-3;
  }
  Variable Variable( kc_k2 )
  { Value 0.13e-6;
  }
  Variable Variable( kc_F1 )
  { Value 96.4853;
  }


  Process ExpressionAssignmentProcess ( kc_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess( kc_ao )
  {
    StepperID  Default;
    Expression  "cai.Value*0.28/( cai.Value+kc_k1.Value*exp( -2*0.84*v.Value*kc_F1.Value/(R.Value*T.Value) ) )";
    VariableReferenceList
      [ kc_ao :/:kc_ao 1 ]
      [ cai :/:cai 0 ]
      [ kc_k1 :/:kc_k1 0 ]
      [ v :/:v 0 ]
      [ kc_F1 :/:kc_F1 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( kc_bo )
  {
    StepperID  Default;
    Expression  "0.48 / ( 1+cai.Value/( kc_k2.Value*exp( -2*1.0*v.Value*kc_F1.Value/(R.Value*T.Value) ) ) )";
    VariableReferenceList
      [ kc_bo :/:kc_bo 1 ]
      [ cai :/:cai 0 ]
      [ kc_k2 :/:kc_k2 0 ]
      [ v :/:v 0 ]
      [ kc_F1 :/:kc_F1 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( kc_tau_o )
  {
    StepperID  Default;
    Expression  "1/(kc_ao.Value+kc_bo.Value)";
    VariableReferenceList
      [ kc_tau_o :/:kc_tau_o 1 ]
      [ kc_ao :/:kc_ao 0 ]
      [ kc_bo :/:kc_bo 0 ];
  }
  Process ExpressionAssignmentProcess( kc_o_inf )
  {
    StepperID  Default;
    Expression  "kc_ao.Value*kc_tau_o.Value";
    VariableReferenceList
      [ kc_o_inf :/:kc_o_inf 1 ]
      [ kc_ao :/:kc_ao 0 ]
      [ kc_tau_o :/:kc_tau_o 0 ];
  }


  Process ExpressionFluxProcess( kc_okc )
  {
    StepperID  Default;
    Expression  "(kc_o_inf.Value/kc_tau_o.Value)/(1/kc_tau_o.Value)";
    VariableReferenceList
      [ okc :/:okc 1 ]
      [ kc_o_inf :/:kc_o_inf 0 ]
      [ kc_tau_o :/:kc_tau_o 0 ];
  }
  Process ExpressionAssignmentProcess( kc_ikc )
  {
    StepperID  Default;
    Expression  "0.01*okc.Value*(v.Value+91)";
    VariableReferenceList
      [ ikc :/:ikc 1 ]
      [ okc :/:okc 0 ]
      [ v :/:v 0 ];
  }
