
  # L-channel
  # L-channel Jaffe et al. 1994. J Neurophisiology
  # cal()?


  Variable Variable( cal_am )
  { Value 0; #tmp
  }
  Variable Variable( cal_bm )
  { Value 0; #tmp
  }
  Variable Variable( cal_tau_m )
  { Value 0; #tmp
  }
  Variable Variable( cal_m_inf )
  { Value 0; #tmp
  }


  Process ExpressionAssignmentProcess ( cal_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }

  Process ExpressionAssignmentProcess( cal_am )
  {
    StepperID  Default;
    Expression  "15.69*(-v.Value+81.5)/(exp((-1.0*v.Value+81.5)/10)-1)";
    VariableReferenceList
      [ cal_am :/:cal_am 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( cal_bm )
  {
    StepperID  Default;
    Expression  "0.29*exp(-1.0*v.Value/10.86)";
    VariableReferenceList
      [ cal_bm :/:cal_bm 1 ]
      [ v :/:v 0 ];
  }
  Process ExpressionAssignmentProcess( cal_tau_m )
  {
    StepperID  Default;
    Expression  "1/(cal_am.Value+cal_bm.Value)";
    VariableReferenceList
      [ cal_tau_m :/:cal_tau_m 1 ]
      [ cal_am :/:cal_am 0 ]
      [ cal_bm :/:cal_bm 0 ];
  }
  Process ExpressionAssignmentProcess( cal_m_inf )
  {
    StepperID  Default;
    Expression  "cal_am.Value*cal_tau_m.Value";
    VariableReferenceList
      [ cal_m_inf :/:cal_m_inf 1 ]
      [ cal_am :/:cal_am 0 ]
      [ cal_tau_m :/:cal_tau_m 0 ];
  }


  Process ExpressionFluxProcess( cal_ml )
  {
    StepperID  Default;
    Expression  "(cal_m_inf.Value/cal_tau_m.Value)/(1/cal_tau_m.Value)";
    VariableReferenceList
      [ ml :/:ml 1 ]
      [ cal_m_inf :/:cal_m_inf 0 ]
      [ cal_tau_m :/:cal_tau_m 0 ];
  }


  Variable Variable( cal_gcal )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess( cal_gcal )
  {
    StepperID  Default;
    Expression  "0.003*ml.Value*ml.Value*( 0.001/(0.001+cai.Value) )";
    VariableReferenceList
      [ cal_gcal :/:cal_gcal 1 ]
      [ ml :/:ml 0 ]
      [ cai :/:cai 0 ];
  }
  Variable Variable( cal_f )
  { 
    Value @( 25/293.15*(303.15) / 2 );
  }
  Variable Variable( cal_nu )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( cal_nu )
  {
    StepperID  Default;
    Expression  "v.Value/cal_f.Value";
    VariableReferenceList
      [ cal_nu :/:cal_nu 1 ]
      [ v :/:v 0 ]
      [ cal_f :/:cal_f 0 ];
  }
  Variable Variable( cal_efun )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( cal_efun )
  {
    StepperID  Default;
    #Expression  "lt( fabs(cal_nu.Value),1e-4 )*(1-cal_nu.Value/2) + geq( fabs(cal_nu.Value),1e-4 )*( cal_nu.Value/( exp(cal_nu.Value)-1 ) )";
    Expression  "lt( abs(cal_nu.Value),0.0001 )*(1-cal_nu.Value/2) + geq( abs(cal_nu.Value),0.0001 )*( cal_nu.Value/( exp(cal_nu.Value)-1 ) )";
    VariableReferenceList
      [ cal_efun :/:cal_efun 1 ]
      [ cal_nu :/:cal_nu 0 ];
  }
  Variable Variable( cal_ghk )
  { 
    Value 0;
  }
  Process ExpressionAssignmentProcess( cal_ghk )
  {
    StepperID  Default;
    Expression  "-1.0*cal_f.Value*(1-cai.Value/cao.Value*exp(cal_nu.Value))*cal_efun.Value";
    VariableReferenceList
      [ cal_ghk :/:cal_ghk 1 ]
      [ cal_f :/:cal_f 0 ]
      [ cai :/:cai 0 ]
      [ cao :/:cao 0 ]
      [ cal_nu :/:cal_nu 0 ]
      [ cal_efun :/:cal_efun 0 ];
  }
  Process ExpressionAssignmentProcess( cal_ical )
  {
    StepperID  Default;
    Expression  "cal_gcal.Value*cal_ghk.Value";
    VariableReferenceList
      [ ical :/:ical 1 ]
      [ cal_gcal :/:cal_gcal 0 ]
      [ cal_ghk :/:cal_ghk 0 ];
  }



  #  K channels 


  #  Kdr channel (Ca-independent k channel)
  #  From Migliore et al. 1995. J Neurophysiology
  #  kdr()


  Variable Variable( kdr_an )
  { Value 0; #tmp
  }
  Variable Variable( kdr_bn )
  { Value 0; #tmp
  }
  Variable Variable( kdr_al )
  { Value 0; #tmp
  }
  Variable Variable( kdr_bl )
  { Value 0; #tmp
  }
  Variable Variable( kdr_tau_n )
  { Value 0; #tmp
  }
  Variable Variable( kdr_tau_l )
  { Value 0; #tmp
  }
  Variable Variable( kdr_n_inf )
  { Value 0; #tmp
  }
  Variable Variable( kdr_l_inf )
  { Value 0; #tmp
  }


  
  Process ExpressionAssignmentProcess ( kdr_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess( kdr_an )
  {
    StepperID  Default;
    #Expression  "0.03*exp(1.e-3*5*0.4*(v.Value+32)*F.Value/(R.Value*T.Value))";
    Expression  "0.03*exp(0.001*5*0.4*(v.Value+32)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ kdr_an :/:kdr_an 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_bn )
  {
    StepperID  Default;
    #Expression  "0.03*exp(-1.e-3*5*0.6*(v.Value+32)*F.Value/(R.Value*T.Value))";
    Expression  "0.03*exp(-0.001*5*0.6*(v.Value+32)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ kdr_bn :/:kdr_bn 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_al )
  {
    StepperID  Default;
    #Expression  " 0.001 * exp( -1.e-3*2*(v.Value+61)*F.Value/(R.Value*T.Value) )";
    Expression  " 0.001 * exp( -0.001*2*(v.Value+61)*F.Value/(R.Value*T.Value) )";
    VariableReferenceList
      [ kdr_al :/:kdr_al 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_bl )
  {
    StepperID  Default;
    Expression  "0.001";
    VariableReferenceList
      [ kdr_bl :/:kdr_bl 1 ];
  }
  Process ExpressionAssignmentProcess( kdr_tau_n )
  {
    StepperID  Default;
    Expression  "1/(kdr_an.Value+kdr_bn.Value)";
    VariableReferenceList
      [ kdr_tau_n :/:kdr_tau_n 1 ]
      [ kdr_an :/:kdr_an 0 ]
      [ kdr_bn :/:kdr_bn 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_tau_l )
  {
    StepperID  Default;
    Expression  "1/(kdr_al.Value+kdr_bl.Value)";
    VariableReferenceList
      [ kdr_tau_l :/:kdr_tau_l 1 ]
      [ kdr_al :/:kdr_al 0 ]
      [ kdr_bl :/:kdr_bl 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_n_inf )
  {
    StepperID  Default;
    Expression  "kdr_an.Value*kdr_tau_n.Value";
    VariableReferenceList
      [ kdr_n_inf :/:kdr_n_inf 1 ]
      [ kdr_an :/:kdr_an 0 ]
      [ kdr_tau_n :/:kdr_tau_n 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_l_inf )
  {
    StepperID  Default;
    Expression  "kdr_al.Value*kdr_tau_l.Value";
    VariableReferenceList
      [ kdr_l_inf :/:kdr_l_inf 1 ]
      [ kdr_al :/:kdr_al 0 ]
      [ kdr_tau_l :/:kdr_tau_l 0 ];
  }


  Process ExpressionFluxProcess( kdr_nkdr )
  {
    StepperID  Default;
    Expression  "(kdr_n_inf.Value/kdr_tau_n.Value)/(1/kdr_tau_n.Value)";
    VariableReferenceList
      [ nkdr :/:nkdr 1 ]
      [ kdr_n_inf :/:kdr_n_inf 0 ]
      [ kdr_tau_n :/:kdr_tau_n 0 ];
  }
  Process ExpressionFluxProcess( kdr_lkdr )
  {
    StepperID  Default;
    Expression  "(kdr_l_inf.Value/kdr_tau_l.Value)/(1/kdr_tau_l.Value)";
    VariableReferenceList
      [ lkdr :/:lkdr 1 ]
      [ kdr_l_inf :/:kdr_l_inf 0 ]
      [ kdr_tau_l :/:kdr_tau_l 0 ];
  }
  Process ExpressionAssignmentProcess( kdr_ikdr )
  {
    StepperID  Default;
    Expression  "gkdr.Value*nkdr.Value*nkdr.Value*nkdr.Value*lkdr.Value*(v.Value+91)";
    VariableReferenceList
      [ ikdr :/:ikdr 1 ]
      [ gkdr :/:gkdr 0 ]
      [ nkdr :/:nkdr 0 ]
      [ lkdr :/:lkdr 0 ]
      [ v :/:v 0 ];
  }

