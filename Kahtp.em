
  #  Kahp channel (Ca-dependent k channel)
  #  From Lyle J. Borg-Graham, 1999  formulation. parameters are from Gold et al., 2006.
  #  kahp_new


  Variable Variable( kahp_new_aw )
  { Value 1e31;
  }
  Variable Variable( kahp_new_bw )
  { Value 0.2;
  }
  Variable Variable( kahp_new_tau_0 )
  { Value 0; #tmp
  }
  Variable Variable( kahp_new_tau_w )
  { Value 0; #tmp
  }
  Variable Variable( kahp_new_w_inf )
  { Value 0; #tmp
  }


  Process ExpressionAssignmentProcess ( kahp_new_cai )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*5e-5+geq(t.Value,dt.Value)*cai.Value";
    VariableReferenceList
      [ cai :/:cai 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }
  Process ExpressionAssignmentProcess ( kahp_new_tau_0 )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*5.0+geq(t.Value,dt.Value)*kahp_new_tau_0.Value";
    VariableReferenceList
      [ kahp_new_tau_0 :/:kahp_new_tau_0 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }


  Process ExpressionAssignmentProcess ( kahp_new_tau_w )
  {
    StepperID  Default;
    Expression  "1/ ( kahp_new_aw.Value*pow(cai.Value,2)+kahp_new_bw.Value ) + kahp_new_tau_0.Value";
    VariableReferenceList
      [ kahp_new_tau_w :/:kahp_new_tau_w 1 ]
      [ kahp_new_aw :/:kahp_new_aw 0 ]
      [ cai :/:cai 0 ]
      [ kahp_new_bw :/:kahp_new_bw 0 ]
      [ kahp_new_tau_0 :/:kahp_new_tau_0 0 ];
  }
  Process ExpressionAssignmentProcess ( kahp_new_w_inf )
  {
    StepperID  Default;
    Expression  "kahp_new_aw.Value*pow(cai.Value,2)/( kahp_new_aw.Value*pow(cai.Value,2)+kahp_new_bw.Value )";
    VariableReferenceList
      [ kahp_new_w_inf :/:kahp_new_w_inf 1 ]
      [ kahp_new_aw :/:kahp_new_aw 0 ]
      [ cai :/:cai 0 ]
      [ kahp_new_bw :/:kahp_new_bw 0 ];
  }


  Process ExpressionFluxProcess( kahp_new_wkahp )
  {
    StepperID  Default;
    Expression  "(kahp_new_w_inf.Value/kahp_new_tau_w.Value)/(1/kahp_new_tau_w.Value)";
    VariableReferenceList
      [ wkahp :/:wkahp 1 ]
      [ kahp_new_w_inf :/:kahp_new_w_inf 0 ]
      [ kahp_new_tau_w :/:kahp_new_tau_w 0 ];
  }
  Process ExpressionAssignmentProcess( kahp_new_ikahp )
  {
    StepperID  Default;
    Expression  "gkahp.Value*pow(wkahp.Value,8)*(v.Value+91)";
    VariableReferenceList
      [ ikahp :/:ikahp 1 ]
      [ gkahp :/:gkahp 0 ]
      [ wkahp :/:wkahp 0 ]
      [ v :/:v 0 ];
  }



  #  leak current or passive current
  #  pas
  Process ExpressionAssignmentProcess( ipas )
  {
    StepperID  Default;
    Expression  "gpas.Value*(v.Value-vrest.Value)";
    VariableReferenceList
      [ ipas :/:ipas 1 ]
      [ gpas :/:gpas 0 ]
      [ v :/:v 0 ]
      [ vrest :/:vrest 0 ];
  }

