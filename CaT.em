

  #Human T-type calcium channels based on Chemin et al., J Physiol., 2002, 540, 3-14.
  #CaT--alpha 1G CaV3.1
  #cat_human_alpha1G()?

  Variable Variable( cat_human_alpha1G_n_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1G_l_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1G_tau_n )
  { Value 0; #tmp
  }


  Variable Variable( cat_human_alpha1G_tau_l )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1G_vv )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1G_gbar )
  { Value 0.008; #s/cm2
  }
  Variable Variable( cat_human_alpha1G_vhalfn )
  { Value -49.3; #mv
  }
  Variable Variable( cat_human_alpha1G_vhalfl )
  { Value -74.2;
  }
  Variable Variable( cat_human_alpha1G_kn )
  { Value 4.6;
  }
  Variable Variable( cat_human_alpha1G_kl )
  { Value -5.5;
  }
  Variable Variable( cat_human_alpha1G_q10 )
  { Value 2.3;
  }
  Variable Variable( cat_human_alpha1G_qt )
  { Value @( pow( 2.3 , 2/10 ) );
  }
  Variable Variable( cat_human_alpha1G_pcabar )
  { Value 0.0001; #cm/s
  }
  Variable Variable( cat_human_alpha1G_z )
  { Value 2;
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1G_vv )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*(-65.0) + geq(t.Value,dt.Value)*cat_human_alpha1G_vv.Value";

    VariableReferenceList
      [ cat_human_alpha1G_vv :/:cat_human_alpha1G_vv 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_n_inf )
  {
    StepperID  Default;
    Expression  "1.0/(1.0 + exp(-(v.Value-cat_human_alpha1G_vhalfn.Value)/cat_human_alpha1G_kn.Value))";
    VariableReferenceList
      [ cat_human_alpha1G_n_inf :/:cat_human_alpha1G_n_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1G_vhalfn :/:cat_human_alpha1G_vhalfn 0 ]
      [ cat_human_alpha1G_kn :/:cat_human_alpha1G_kn 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_l_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1G_vhalfl.Value)/cat_human_alpha1G_kl.Value))";
    VariableReferenceList
      [ cat_human_alpha1G_l_inf :/:cat_human_alpha1G_l_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1G_vhalfl :/:cat_human_alpha1G_vhalfl 0 ]
      [ cat_human_alpha1G_kl :/:cat_human_alpha1G_kl 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_tau_n )
  {
    StepperID  Default;
    Expression  "lt(-56,v.Value)*( (0.8+0.025*exp(-v.Value/14.5))/cat_human_alpha1G_qt.Value ) + geq(-56,v.Value)*( (1.71*exp((v.Value+120)/38))/cat_human_alpha1G_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1G_tau_n :/:cat_human_alpha1G_tau_n 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1G_qt :/:cat_human_alpha1G_qt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_tau_l )
  {
    StepperID  Default;
    Expression  "lt(-60,v.Value)*( (12.3+0.12*exp(-v.Value/10.8))/cat_human_alpha1G_qt.Value ) + geq(-60,v.Value)*( 137/cat_human_alpha1G_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1G_tau_l :/:cat_human_alpha1G_tau_l 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1G_qt :/:cat_human_alpha1G_qt 0 ];
  }
  Process ExpressionFluxProcess( cat_human_alpha1G_ntg )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1G_n_inf.Value/cat_human_alpha1G_tau_n.Value)/(1.0/cat_human_alpha1G_tau_n.Value)";
    VariableReferenceList
      [ ntg :/:ntg 1 ]
      [ cat_human_alpha1G_n_inf :/:cat_human_alpha1G_n_inf 0 ]
      [ cat_human_alpha1G_tau_n :/:cat_human_alpha1G_tau_n 0 ];
  }
  Process ExpressionFluxProcess( cat_human_alpha1G_ltg )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1G_l_inf.Value/cat_human_alpha1G_tau_l.Value)/(1/cat_human_alpha1G_tau_l.Value)";
    VariableReferenceList
      [ ltg :/:ltg 1 ]
      [ cat_human_alpha1G_l_inf :/:cat_human_alpha1G_l_inf 0 ]
      [ cat_human_alpha1G_tau_l :/:cat_human_alpha1G_tau_l 0 ];
  }
  
  Variable Variable( cat_human_alpha1G_w )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_w )
  {
    StepperID  Default;
    Expression  "v.Value*0.001*cat_human_alpha1G_z.Value*F.Value/(R.Value*(celsius.Value+273.16))";
    VariableReferenceList
      [ cat_human_alpha1G_w :/:cat_human_alpha1G_w 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1G_z :/:cat_human_alpha1G_z 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ celsius :/:celsius 0 ];
  }
  Variable Variable( cat_human_alpha1G_ghk )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_ghk )
  {
	Priority -5;
    StepperID  Default;
#    Expression  "-0.001*cat_human_alpha1G_z.Value*F.Value*(cao.Value-cai.Value*exp(cat_human_alpha1G_w.Value))*cat_human_alpha1G_w.Value/(exp(cat_human_alpha1G_w.Value)-1)";
    Expression  "-0.001*cat_human_alpha1G_z.Value*F.Value*(cao.Value-cai.Value*exp(cat_human_alpha1G_w.Value))*cat_human_alpha1G_w.Value/(exp(1.0)-1)";
    VariableReferenceList
      [ cat_human_alpha1G_ghk :/:cat_human_alpha1G_ghk 1 ]
      [ cat_human_alpha1G_z :/:cat_human_alpha1G_z 0 ]
      [ F :/:F 0 ]
      [ cao :/:cao 0 ]
      [ cai :/:cai 0 ]
      [ cat_human_alpha1G_w :/:cat_human_alpha1G_w 0 ];
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1G_icat_alpha1G )
  {
    StepperID  Default;
    Expression  "gcat31.Value*cat_human_alpha1G_pcabar.Value*ntg.Value*ntg.Value*ltg.Value*cat_human_alpha1G_ghk.Value";
    VariableReferenceList
      [ icat_alpha1G :/:icat_alpha1G 1 ]
      [ gcat31 :/:gcat31 0 ]
      [ cat_human_alpha1G_pcabar :/:cat_human_alpha1G_pcabar 0 ]
      [ ntg :/:ntg 0 ]
      [ ltg :/:ltg 0 ]
      [ cat_human_alpha1G_ghk :/:cat_human_alpha1G_ghk 0 ];
  }



  #CaT--alpha 1H  CaV3.2
  #based on Vitko et al., 2005, J Neurosci, 25, 4844-4855
  #provided by Dr Edward Perez-Reyes on 6/30/05
  #cat_human_alpha1H

  Variable Variable( cat_human_alpha1H_n_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1H_l_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1H_tau_n )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1H_tau_l )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1H_vv )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1H_gbar )
  { Value 0.008; #s/cm2
  }
  Variable Variable( cat_human_alpha1H_vhalfn )
  { Value -48.4; #mv
  }
  Variable Variable( cat_human_alpha1H_vhalfl )
  { Value -75.6;
  }
  Variable Variable( cat_human_alpha1H_kn )
  { Value 5.2;
  }
  Variable Variable( cat_human_alpha1H_kl )
  { Value -6.2;
  }
  Variable Variable( cat_human_alpha1H_q10 )
  { Value 2.3;
  }
  Variable Variable( cat_human_alpha1H_qt )
  { Value @( pow( 2.3 , 2/10 ) );
  }
  Variable Variable( cat_human_alpha1H_pcabar )
  { Value 0.0001; #cm/s
  }
  Variable Variable( cat_human_alpha1H_z )
  { Value 2;
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1H_vv )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*cat_human_alpha1H_vv.Value";
    VariableReferenceList
      [ cat_human_alpha1H_vv :/:cat_human_alpha1H_vv 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_n_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1H_vhalfn.Value)/cat_human_alpha1H_kn.Value))";
    VariableReferenceList
      [ cat_human_alpha1H_n_inf :/:cat_human_alpha1H_n_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1H_vhalfn :/:cat_human_alpha1H_vhalfn 0 ]
      [ cat_human_alpha1H_kn :/:cat_human_alpha1H_kn 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_l_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1H_vhalfl.Value)/cat_human_alpha1H_kl.Value))";
    VariableReferenceList
      [ cat_human_alpha1H_l_inf :/:cat_human_alpha1H_l_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1H_vhalfl :/:cat_human_alpha1H_vhalfl 0 ]
      [ cat_human_alpha1H_kl :/:cat_human_alpha1H_kl 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_tau_n )
  {
    StepperID  Default;
    Expression  "lt(-56,v.Value)*( (1.34+0.035*exp(-v.Value/11.8))/cat_human_alpha1H_qt.Value ) + geq(-56,v.Value)*( (2.44*exp((v.Value+120)/40))/cat_human_alpha1H_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1H_tau_n :/:cat_human_alpha1H_tau_n 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1H_qt :/:cat_human_alpha1H_qt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_tau_l )
  {
    StepperID  Default;
    Expression  "lt(-60,v.Value)*( (18.3+0.005*exp(-v.Value/6.2))/cat_human_alpha1H_qt.Value ) + geq(-60,v.Value)*( 500/cat_human_alpha1H_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1H_tau_l :/:cat_human_alpha1H_tau_l 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1H_qt :/:cat_human_alpha1H_qt 0 ];
  }
  #tau_n = (1.9+1.0/(exp((v+21.0)/11.9)+exp(-(v+115)/21)))/qt;
  #tau_l = (18.3+(1942+exp((v+164)/9.2))/(1+exp((v+89.3)/3.7)))/qt;
  Process ExpressionFluxProcess( cat_human_alpha1H_nth )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1H_n_inf.Value/cat_human_alpha1H_tau_n.Value)/(1/cat_human_alpha1H_tau_n.Value)";
    VariableReferenceList
      [ nth :/:nth 1 ]
      [ cat_human_alpha1H_n_inf :/:cat_human_alpha1H_n_inf 0 ]
      [ cat_human_alpha1H_tau_n :/:cat_human_alpha1H_tau_n 0 ];
  }
  Process ExpressionFluxProcess( cat_human_alpha1H_lth )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1H_l_inf.Value/cat_human_alpha1H_tau_l.Value)/(1/cat_human_alpha1H_tau_l.Value)";
    VariableReferenceList
      [ lth :/:lth 1 ]
      [ cat_human_alpha1H_l_inf :/:cat_human_alpha1H_l_inf 0 ]
      [ cat_human_alpha1H_tau_l :/:cat_human_alpha1H_tau_l 0 ];
  }
  
  Variable Variable( cat_human_alpha1H_w )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_w )
  {
    StepperID  Default;
    Expression  "v.Value*0.001*cat_human_alpha1H_z.Value*F.Value/(R.Value*(celsius.Value+273.16))";
    VariableReferenceList
      [ cat_human_alpha1H_w :/:cat_human_alpha1H_w 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1H_z :/:cat_human_alpha1H_z 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ celsius :/:celsius 0 ];
  }
  Variable Variable( cat_human_alpha1H_ghk )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1H_ghk )
  {
    StepperID  Default;
    Expression  "-0.001*cat_human_alpha1H_z.Value*F.Value*(cao.Value-cai.Value*exp(cat_human_alpha1H_w.Value))*cat_human_alpha1H_w.Value/(exp(cat_human_alpha1H_w.Value)-1)";
    VariableReferenceList
      [ cat_human_alpha1H_ghk :/:cat_human_alpha1H_ghk 1 ]
      [ cat_human_alpha1H_z :/:cat_human_alpha1H_z 0 ]
      [ F :/:F 0 ]
      [ cao :/:cao 0 ]
      [ cai :/:cai 0 ]
      [ cat_human_alpha1H_w :/:cat_human_alpha1H_w 0 ];
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1H_icat_alpha1H )
  {
    StepperID  Default;
    Expression  "gcat32.Value*cat_human_alpha1H_pcabar.Value*nth.Value*nth.Value*lth.Value*cat_human_alpha1H_ghk.Value";
    VariableReferenceList
      [ icat_alpha1H :/:icat_alpha1H 1 ]
      [ gcat32 :/:gcat32 0 ]
      [ cat_human_alpha1H_pcabar :/:cat_human_alpha1H_pcabar 0 ]
      [ nth :/:nth 0 ]
      [ lth :/:lth 0 ]
      [ cat_human_alpha1H_ghk :/:cat_human_alpha1H_ghk 0 ];
  }



  #CaT--alpha 1I CaV3.3
  #cat_human_alpha1I?

  Variable Variable( cat_human_alpha1I_n_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1I_l_inf )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1I_tau_n )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1I_tau_l )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1I_vv )
  { Value 0; #tmp
  }
  Variable Variable( cat_human_alpha1I_gbar )
  { Value 0.008; #s/cm2
  }
  Variable Variable( cat_human_alpha1I_vhalfn )
  { Value -41.5; #mv
  }
  Variable Variable( cat_human_alpha1I_vhalfl )
  { Value -69.8;
  }
  Variable Variable( cat_human_alpha1I_kn )
  { Value 6.2;
  }
  Variable Variable( cat_human_alpha1I_kl )
  { Value -6.1;
  }
  Variable Variable( cat_human_alpha1I_q10 )
  { Value 2.3;
  }
  Variable Variable( cat_human_alpha1I_qt )
  { Value @( pow( 2.3 , 2/10 ) );
  }
  Variable Variable( cat_human_alpha1I_pcabar )
  { Value 0.0001; #cm/s
  }
  Variable Variable( cat_human_alpha1I_z )
  { Value 2;
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1I_vv )
  {
    StepperID  Default;
    Expression  "lt(t.Value,dt.Value)*-65+geq(t.Value,dt.Value)*cat_human_alpha1I_vv.Value";
    VariableReferenceList
      [ cat_human_alpha1I_vv :/:cat_human_alpha1I_vv 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_n_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1I_vhalfn.Value)/cat_human_alpha1I_kn.Value))";
    VariableReferenceList
      [ cat_human_alpha1I_n_inf :/:cat_human_alpha1I_n_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1I_vhalfn :/:cat_human_alpha1I_vhalfn 0 ]
      [ cat_human_alpha1I_kn :/:cat_human_alpha1I_kn 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_l_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1I_vhalfl.Value)/cat_human_alpha1I_kl.Value))";
    VariableReferenceList
      [ cat_human_alpha1I_l_inf :/:cat_human_alpha1I_l_inf 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1I_vhalfl :/:cat_human_alpha1I_vhalfl 0 ]
      [ cat_human_alpha1I_kl :/:cat_human_alpha1I_kl 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_tau_n )
  {
    StepperID  Default;
    Expression  "lt(-60,v.Value)*( (7.2+0.02*exp(-v.Value/14.7))/cat_human_alpha1I_qt.Value ) + geq(-60,v.Value)*( (0.875*exp((v.Value+120)/41))/cat_human_alpha1I_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1I_tau_n :/:cat_human_alpha1I_tau_n 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1I_qt :/:cat_human_alpha1I_qt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_tau_l )
  {
    StepperID  Default;
    Expression  "lt(-60,v.Value)*( (79.5+2.0*exp(-v.Value/9.3))/cat_human_alpha1I_qt.Value ) + geq(-60,v.Value)*( 260/cat_human_alpha1I_qt.Value )";
    VariableReferenceList
      [ cat_human_alpha1I_tau_l :/:cat_human_alpha1I_tau_l 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1I_qt :/:cat_human_alpha1I_qt 0 ];
  }
  #tau_n = (9.3+8.0/(exp((v+30.0)/11.9)+exp(-(v+120)/21)))/qt;
  #tau_l = (13.7+(1942+exp((v+164)/9.2))/(1+exp((v+89.3)/3.7)))/qt;
  Process ExpressionFluxProcess( cat_human_alpha1I_nti )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1I_n_inf.Value/cat_human_alpha1I_tau_n.Value)/(1/cat_human_alpha1I_tau_n.Value)";
    VariableReferenceList
      [ nti :/:nti 1 ]
      [ cat_human_alpha1I_n_inf :/:cat_human_alpha1I_n_inf 0 ]
      [ cat_human_alpha1I_tau_n :/:cat_human_alpha1I_tau_n 0 ];
  }
  Process ExpressionFluxProcess( cat_human_alpha1I_lti )
  {
    StepperID  Default;
    Expression  "(cat_human_alpha1I_l_inf.Value/cat_human_alpha1I_tau_l.Value)/(1/cat_human_alpha1I_tau_l.Value)";
    VariableReferenceList
      [ lti :/:lti 1 ]
      [ cat_human_alpha1I_l_inf :/:cat_human_alpha1I_l_inf 0 ]
      [ cat_human_alpha1I_tau_l :/:cat_human_alpha1I_tau_l 0 ];
  }
  
  Variable Variable( cat_human_alpha1I_w )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_w )
  {
    StepperID  Default;
    Expression  "v.Value*0.001*cat_human_alpha1I_z.Value*F.Value/(R.Value*(celsius.Value+273.16))";
    VariableReferenceList
      [ cat_human_alpha1I_w :/:cat_human_alpha1I_w 1 ]
      [ v :/:v 0 ]
      [ cat_human_alpha1I_z :/:cat_human_alpha1I_z 0 ]
      [ F :/:F 0 ]
      [ R :/:R 0 ]
      [ celsius :/:celsius 0 ];
  }
  Variable Variable( cat_human_alpha1I_ghk )
  { Value 0; #tmp
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1I_ghk )
  {
    StepperID  Default;
    Expression  "-0.001*cat_human_alpha1I_z.Value*F.Value*(cao.Value-cai.Value*exp(cat_human_alpha1I_w.Value))*cat_human_alpha1I_w.Value/(exp(cat_human_alpha1I_w.Value)-1)";
    VariableReferenceList
      [ cat_human_alpha1I_ghk :/:cat_human_alpha1I_ghk 1 ]
      [ cat_human_alpha1I_z :/:cat_human_alpha1I_z 0 ]
      [ F :/:F 0 ]
      [ cao :/:cao 0 ]
      [ cai :/:cai 0 ]
      [ cat_human_alpha1I_w :/:cat_human_alpha1I_w 0 ];
  }

  Process ExpressionAssignmentProcess ( cat_human_alpha1I_icat_alpha1I )
  {
    StepperID  Default;
    Expression  "gcat33.Value*cat_human_alpha1I_pcabar.Value*nti.Value*nti.Value*lti.Value*cat_human_alpha1I_ghk.Value";
    VariableReferenceList
      [ icat_alpha1I :/:icat_alpha1I 1 ]
      [ gcat33 :/:gcat33 0 ]
      [ cat_human_alpha1I_pcabar :/:cat_human_alpha1I_pcabar 0 ]
      [ nti :/:nti 0 ]
      [ lti :/:lti 0 ]
      [ cat_human_alpha1I_ghk :/:cat_human_alpha1I_ghk 0 ];
  }
