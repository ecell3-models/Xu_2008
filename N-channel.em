  # N-channel
  # N-channel from Jaffe et al. 1994, J of Neurophisiology
  # can()?
  # causing non?


  Variable Variable( can_am )
  { Value 0; #tmp
  }
  Variable Variable( can_bm )
  { Value 0; #tmp
  }
  Variable Variable( can_ah )
  { Value 0; #tmp
  }
  Variable Variable( can_bh )
  { Value 0; #tmp
  }
  Variable Variable( can_tau_m )
  { Value 0; #tmp
  }
  Variable Variable( can_tau_h )
  { Value 0; #tmp
  }
  Variable Variable( can_m_inf )
  { Value 0; #tmp
  }
  Variable Variable( can_h_inf )
  { Value 0; #tmp
  }

  Process ExpressionAssignmentProcess ( can_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess( can_am )
  {
    StepperID  Default;
    Expression  "0.1967*(-v.Value+19.88)/(exp((-v.Value+19.88)/10)-1)";
    VariableReferenceList
      [ can_am :/:can_am 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( can_bm )
  {
    StepperID  Default;
    Expression  "0.046*exp(-v.Value/20.73)";
    VariableReferenceList
      [ can_bm :/:can_bm 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( can_ah )
  {
    StepperID  Default;
    Expression  "1.6e-4*exp(-v.Value/48.4)";
    VariableReferenceList
      [ can_ah :/:can_ah 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( can_bh )
  {
    StepperID  Default;
    Expression  "1/(exp((-v.Value+39)/10)+1)";
    VariableReferenceList
      [ can_bh :/:can_bh 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( can_tau_m )
  {
    StepperID  Default;
    Expression  "1/(can_am.Value+can_bm.Value)";
    VariableReferenceList
      [ can_tau_m :/:can_tau_m 1 ]
      [ can_am :/:can_am 0 ]
      [ can_bm :/:can_bm 0 ];
  }
  Process ExpressionAssignmentProcess( can_tau_h )
  {
    StepperID  Default;
    Expression  "1/(can_ah.Value+can_bh.Value)";
    VariableReferenceList
      [ can_tau_h :/:can_tau_h 1 ]
      [ can_ah :/:can_ah 0 ]
      [ can_bh :/:can_bh 0 ];
  }
  Process ExpressionAssignmentProcess( can_m_inf )
  {
    StepperID  Default;
    Expression  "can_am.Value*can_tau_m.Value";
    VariableReferenceList
      [ can_m_inf :/:can_m_inf 1 ]
      [ can_am :/:can_am 0 ]
      [ can_tau_m :/:can_tau_m 0 ];
  }
  Process ExpressionAssignmentProcess( can_h_inf )
  {
    StepperID  Default;
    Expression  "can_ah.Value*can_tau_h.Value";
    VariableReferenceList
      [ can_h_inf :/:can_h_inf 1 ]
      [ can_ah :/:can_ah 0 ]
      [ can_tau_h :/:can_tau_h 0 ];
  }


  Process ExpressionFluxProcess( can_mn )
  {
    StepperID  Default;
    Expression  "(can_m_inf.Value/can_tau_m.Value)/(1/can_tau_m.Value)";
    VariableReferenceList
      [ mn :/:mn 1 ]
      [ can_m_inf :/:can_m_inf 0 ]
      [ can_tau_m :/:can_tau_m 0 ];
  }
  Process ExpressionFluxProcess( can_hn )
  {
    StepperID  Default;
    Expression  "(can_h_inf.Value/can_tau_h.Value)/(1/can_tau_h.Value)";
    VariableReferenceList
      [ hn :/:hn 1 ]
      [ can_h_inf :/:can_h_inf 0 ]
      [ can_tau_h :/:can_tau_h 0 ];
  }


  Variable Variable( can_f )
  { 
    #  double KTF = 25/293.15*(celsius+273.15);
    #  double f = KTF/2;
    Value @( (25/293.15*303.15) / 2 );
  }
  Variable Variable( can_ki )
  { 
    Value 0.001;
  }
  Variable Variable( can_nu )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( can_nu )
  {
    StepperID  Default;
    Expression  "v.Value/can_f.Value";
    VariableReferenceList
      [ can_nu :/:can_nu 1 ]
      [ v :/:v 0 ]
      [ can_f :/:can_f 0 ];
  }
  Variable Variable( can_efun )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( can_efun )
  {
    StepperID  Default;
    #Expression  "lt( fabs(can_nu.Value),1e-4 )*(1-can_nu.Value/2) + geq( fabs(can_nu.Value),1e-4 )*( can_nu.Value/( exp(can_nu.Value)-1 ) )";
    Expression  "lt( abs(can_nu.Value),0.0001 )*(1-can_nu.Value/2) + geq( abs(can_nu.Value),0.0001 )*( can_nu.Value/( exp(can_nu.Value)-1 ) )";
    VariableReferenceList
      [ can_efun :/:can_efun 1 ]
      [ can_nu :/:can_nu 0 ];
  }
  Variable Variable( can_ghk )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( can_ghk )
  {
    StepperID  Default;
    Expression  "-1.0*can_f.Value*( 1-cai.Value/cao.Value*exp(can_nu.Value) )*can_efun.Value";
    VariableReferenceList
      [ can_ghk :/:can_ghk 1 ]
      [ can_f :/:can_f 0 ]
      [ cai :/:cai 0 ]
      [ cao :/:cao 0 ]
      [ can_nu :/:can_nu 0 ]
      [ can_efun :/:can_efun 0 ];
  }
  Variable Variable( can_gcan )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( can_gcan )
  {
    StepperID  Default;
    Expression  "0.0003*mn.Value*mn.Value*hn.Value*0.001/(0.001+cai.Value)";
    VariableReferenceList
      [ can_gcan :/:can_gcan 1 ]
      [ mn :/:mn 0 ]
      [ hn :/:hn 0 ]
      [ cai :/:cai 0 ];
  }
  Process ExpressionAssignmentProcess( can_ican )
  {
    StepperID  Default;
    Expression  "can_gcan.Value*can_ghk.Value";
    VariableReferenceList
      [ ican :/:ican 1 ]
      [ can_gcan :/:can_gcan 0 ]
      [ can_ghk :/:can_ghk 0 ];
  }


