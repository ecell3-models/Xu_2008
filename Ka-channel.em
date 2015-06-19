

  #  Ka channel (Ca-independent k channel)
  #  From Migliore et al. 1995. J Neurophysiology
  #  ka()


  Variable Variable( ka_an )
  { Value 0; #tmp
  }
  Variable Variable( ka_bn )
  { Value 0; #tmp
  }
  Variable Variable( ka_al )
  { Value 0; #tmp
  }
  Variable Variable( ka_bl )
  { Value 0; #tmp
  }
  Variable Variable( ka_tau_n )
  { Value 0; #tmp
  }
  Variable Variable( ka_tau_l )
  { Value 0; #tmp
  }
  Variable Variable( ka_n_inf )
  { Value 0; #tmp
  }
  Variable Variable( ka_l_inf )
  { Value 0; #tmp
  }


  Process ExpressionAssignmentProcess ( ka_v )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*v.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess( ka_an )
  {
    StepperID  Default;
    #Expression  "0.02*exp(1.e-3*3*0.6*(v.Value+33.6)*F.Value/(R.Value*T.Value))";
    Expression  "0.02*exp(0.001*3*0.6*(v.Value+33.6)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ ka_an :/:ka_an 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( ka_bn )
  {
    StepperID  Default;
    #Expression  "0.02*exp(-1.e-3*1.2*(v.Value+33.6)*F.Value/(R.Value*T.Value))";
    Expression  "0.02*exp(-0.001*1.2*(v.Value+33.6)*F.Value/(R.Value*T.Value))";
    VariableReferenceList
      [ ka_bn :/:ka_bn 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( ka_al )
  {
    StepperID  Default;
    #Expression  "0.08*exp( -1.e-3*4*(v.Value+83)*F.Value/(R.Value*T.Value) )";
    Expression  "0.08*exp( -0.001*4*(v.Value+83)*F.Value/(R.Value*T.Value) )";
    VariableReferenceList
      [ ka_al :/:ka_al 1 ]
      [ v :/:v 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ T :/:T 0 ];
  }
  Process ExpressionAssignmentProcess( ka_bl )
  {
    StepperID  Default;
    Expression  "0.08";
    VariableReferenceList
      [ ka_bl :/:ka_bl 1 ];
  }
  Process ExpressionAssignmentProcess( ka_tau_n )
  {
    StepperID  Default;
    Expression  "1/(ka_an.Value+ka_bn.Value)";
    VariableReferenceList
      [ ka_tau_n :/:ka_tau_n 1 ]
      [ ka_an :/:ka_an 0 ]
      [ ka_bn :/:ka_bn 0 ];
  }
  Process ExpressionAssignmentProcess( ka_tau_l )
  {
    StepperID  Default;
    Expression  "1/(ka_al.Value+ka_bl.Value)";
    VariableReferenceList
      [ ka_tau_l :/:ka_tau_l 1 ]
      [ ka_al :/:ka_al 0 ]
      [ ka_bl :/:ka_bl 0 ];
  }
  Process ExpressionAssignmentProcess( ka_n_inf )
  {
    StepperID  Default;
    Expression  "ka_an.Value*ka_tau_n.Value";
    VariableReferenceList
      [ ka_n_inf :/:ka_n_inf 1 ]
      [ ka_an :/:ka_an 0 ]
      [ ka_tau_n :/:ka_tau_n 0 ];
  }
  Process ExpressionAssignmentProcess( ka_l_inf )
  {
    StepperID  Default;
    Expression  "ka_al.Value*ka_tau_l.Value";
    VariableReferenceList
      [ ka_l_inf :/:ka_l_inf 1 ]
      [ ka_al :/:ka_al 0 ]
      [ ka_tau_l :/:ka_tau_l 0 ];
  }


  Process ExpressionFluxProcess( ka_nka )
  {
    StepperID  Default;
    Expression  "(ka_n_inf.Value/ka_tau_n.Value)/(1/ka_tau_n.Value)";
    VariableReferenceList
      [ nka :/:nka 1 ]
      [ ka_n_inf :/:ka_n_inf 0 ]
      [ ka_tau_n :/:ka_tau_n 0 ];
  }
  Process ExpressionFluxProcess( ka_lka )
  {
    StepperID  Default;
    Expression  "(ka_l_inf.Value/ka_tau_l.Value)/(1/ka_tau_l.Value)";
    VariableReferenceList
      [ lka :/:lka 1 ]
      [ ka_l_inf :/:ka_l_inf 0 ]
      [ ka_tau_l :/:ka_tau_l 0 ];
  }
  Process ExpressionAssignmentProcess( ka_ika )
  {
    StepperID  Default;
    Expression  "gka.Value*nka.Value*lka.Value*(v.Value+91.0)";
    VariableReferenceList
      [ ika :/:ika 1 ]
      [ gka :/:gka 0 ]
      [ nka :/:nka 0 ]
      [ lka :/:lka 0 ]
      [ v :/:v 0 ];
  }

