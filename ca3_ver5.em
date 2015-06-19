# Cell model: CA3 hippocampal neuron

# Stepper?
Stepper FixedODE1Stepper( Default )
  {
    # no property
  }

System System( / )
{
  StepperID  Default;


  # SIZE?
  Variable Variable( SIZE )
  {
      Value  1.0;
  }

  # t?
  Variable Variable( t )
  {
    Value  1;
  }
  # dt?
  Variable Variable( dt )
  {
    Value  1;
  }


  # define constant parameters
  
  # Farady constant (coulomb/mol)
  Variable Variable( F )
  {
    Value  96520;
  }
  
  # gas constant (J/K.mol)
  Variable Variable( R )
  {
    Value  8.3134;
  }
  
  Variable Variable( PI )
  {
    Value  3.14;
  }
  
  Variable Variable( celsius )
  {
    Value  30;
  }
  
  # absolute temperature (K)
  Variable Variable( T )
  {
    # celsius+273.14
    Value 303.14;
  }
  
  # define initial ionic concentration
  
  # (Mv)
  Variable Variable( cai_init )
  {
    Value  5.0e-5;
  }
  
  # (Mv)
  Variable Variable( cao )
  {
    Value  2;
  }

  
  #define membrane properties
  
  Variable Variable( Rm )
  {
    Value  60000;
  }

  # units
  Variable Variable( cm )
  {
    Value  @(1.0*1.0e-3);
  }

  # units
  Variable Variable( Ra )
  {
    Value  @(200*1.0e-4);
  }

  # (mv)
  Variable Variable( vrest )
  {
    Value  -65;
  }
  
  Variable Variable( vinit )
  {
    # vinit = vrest
    Value  -65;
  }
  
  Variable Variable( vk )
  {
    Value  -91;
  }
  
  Variable Variable( vna )
  {
    Value  50;
  }


  # Membrane voltage
  Variable Variable( v )
  {
    #tmp
    Value 0; 
  }


  #define ionic conductances (S/cm^2)
  
  Variable Variable( gna11 )
  {
    Value  2.0;
  }
  
  Variable Variable( gcatbar )
  {
    Value  0.45;
  }
  
  Variable Variable( gcat31 )
  {
    Value  0.45;
  }
  
  Variable Variable( gcat32 )
  {
    Value  0.45;
  }
  
  Variable Variable( gcat33 )
  {
    Value  0.45;
  }
  
  Variable Variable( gcatbar_C4565 )
  {
    Value  @( 1.6*0.45 );
  }
  
  Variable Variable( gcanbar )
  {
    Value  0.0025;
  }
  
  Variable Variable( gcalbar )
  {
    Value  0.0025;
  }
  
  Variable Variable( gkdr )
  {
    Value  0.08;
  }
  
  Variable Variable( gka )
  {
    Value  0.0001;
  }
  
  Variable Variable( gkm )
  {
    Value  0.00002;
  }
  
  Variable Variable( gkc )
  {
    Value  0.00005;
  }
  
  Variable Variable( gkahp )
  { # tmp
    Value  0.0000018;
  }
  
  Variable Variable( gpas )
  {
    # Value  1/Rm
    Value  @(1.0/60000);
  }

  #  define ionic concentration  & currents
  #  記録用では？
  #  全体をコメントアウトする?
  Variable Variable( cai )
  { Value  5.0e-5;  #  mM
  }
  Variable Variable( ina )
  { Value 0; #tmp
  }
  Variable Variable( ina11 )
  { Value 0; #tmp
  }
  Variable Variable( icat )
  { Value 0; #tmp
  }
  Variable Variable( icat_alpha1G )
  { Value 0; #tmp
  }
  Variable Variable( icat_alpha1H )
  { Value 0; #tmp
  }
  Variable Variable( icat_alpha1I )
  { Value 0; #tmp
  }
  Variable Variable( iC4565 )
  { Value 0; #tmp
  }
  Variable Variable( ican )
  { Value 0; #tmp
  }
  Variable Variable( ical )
  { Value 0; #tmp
  }
  Variable Variable( ica )
  { Value 0; #tmp
  }
  Variable Variable( ikdr )
  { Value 0; #tmp
  }
  Variable Variable( ika )
  { Value 0; #tmp
  }
  Variable Variable( ikm )
  { Value 0; #tmp
  }
  Variable Variable( ikc )
  { Value 0; #tmp
  }
  Variable Variable( ikahp )
  { Value 0; #tmp
  }
  Variable Variable( ipas )
  { Value 0; #tmp
  }
  Variable Variable( ion )
  { Value 0; #tmp
  }
  Variable Variable( current )
  { Value 0; #tmp
  }
  Variable Variable( Ist )
  { Value 0; #tmp   
  }



  # gating variables
  
  # Na1.1 gates
  Variable Variable( Na_MC3 )
  { Value 0; #tmp
  }
  Variable Variable( Na_MC )
  { Value 0; #tmp
  }
  Variable Variable( Na_MO )
  { Value 0; #tmp
  }
  Variable Variable( Na_MI )
  { Value 0; #tmp
  }
  Variable Variable( Na_MIs )
  { Value 0; #tmp
  }
  Variable Variable( Na_MC2 )
  { Value 0; #tmp
  }
  Variable Variable( IC3 )
  { Value 0; #tmp
  }
  Variable Variable( IC2 )
  { Value 0; #tmp
  }
  Variable Variable( Na_MIs2 )
  { Value 0; #tmp
  }
  Variable Variable( M_C3 )
  { Value 0; #tmp
  }
  Variable Variable( M_C2 )
  { Value 0; #tmp
  }
  Variable Variable( M_C )
  { Value 0; #tmp
  }
  Variable Variable( M_O )
  { Value 0; #tmp
  }
  Variable Variable( M_OP )
  { Value 0; #tmp
  }
  Variable Variable( Na_OP )
  { Value 0; #tmp
  }
  Variable Variable( Na_O )
  { Value 0; #tmp
  }
  Variable Variable( OPs )
  { Value 0; #tmp
  }
  Variable Variable( M_IF )
  { Value 0; #tmp
  }
  Variable Variable( ina11_wt )
  { Value 0.0;
  }
  Variable Variable( ina11_mt )
  { Value 0.0;
  }
  # Ca N and L type channel gates  3Variables 
  Variable Variable( mn )
  { Value 0; #tmp
  }
  Variable Variable( hn )
  { Value 0; #tmp
  }
  Variable Variable( ml )
  { Value 0; #tmp
  } 
  # CaT gates
  Variable Variable( nth )
  { Value 0; #tmp
  }
  Variable Variable( lth )
  { Value 0; #tmp
  }
  Variable Variable( ntg )
  { Value 0; #tmp
  }
  Variable Variable( ltg )
  { Value 0; #tmp
  }
  Variable Variable( nti )
  { Value 0; #tmp
  }
  Variable Variable( lti )
  { Value 0; #tmp
  }
  # CaT mutant gates
  Variable Variable( ntC4565 )
  { Value 0; #tmp
  }
  Variable Variable( ltC4565 )
  { Value 0; #tmp
  }
  # K gates
  Variable Variable( nkdr )
  { Value 0; #tmp
  }
  Variable Variable( lkdr )
  { Value 0; #tmp
  }
  Variable Variable( nka )
  { Value 0; #tmp
  }
  Variable Variable( lka )
  { Value 0; #tmp
  }
  Variable Variable( mkm )
  { Value 0; #tmp
  }
  Variable Variable( okc )
  { Value 0; #tmp
  }
  Variable Variable( wkahp )
  { Value 0; #tmp
  }



  # gloable variables
  # segment number from 1: number of segments
  Variable Variable( seg )
  { Value 0; #tmp
  }



  # geometry parameters
  Variable Variable( area )
  { Value 0; #tmp
  }
  Variable Variable( diam )
  { Value 0; #tmp
  }
  Variable Variable( dx )
  { Value 0; #tmp
  }
  Variable Variable( g )
  { Value 0; #tmp
  }



  #  [Ca2+] dynamics using a simplified form
  #  ca_dyn

  Process ExpressionFluxProcess( cai )
  {
    StepperID  Default;
    # cai[0] = cai[0] +0.1*dt*(-0.15*ica[0]+(-cai[0])/5)
    Expression  "0.1*(-0.15*ica.Value+(-1.0*cai.Value)/5.0)";
    VariableReferenceList
      [ cai :/:cai 1 ]
      [ ica :/:ica 0 ];
  }



  #  CA3 hippocampal neuron geometry (single-compartment model)
  # geo()

  #  define dimension
  #  soma
  Variable Variable( r3 )
  {
    Value  15;
  }
  Variable Variable( L3 )
  {
    Value  25.5;
  }
  #  define segment length, diameter, area assumng dx = 1, and resistances
  Process ExpressionAssignmentProcess( diam )
  {
    StepperID  Default;
    Expression  "2.0*r3.Value";
    VariableReferenceList
      [ diam :/:diam 1 ]
      [ r3 :/:r3 0 ];
  }
  Process ExpressionAssignmentProcess( dx )
  {
    StepperID  Default;
    Expression  "L3.Value/1";
    VariableReferenceList
      [ dx :/:dx 1 ]
      [ L3 :/:L3 0 ];
  }
  Process ExpressionAssignmentProcess( area )
  {
    StepperID  Default;
    Expression  "PI.Value*diam.Value";
    VariableReferenceList
      [ area :/:area 1 ]
      [ PI :/:PI 0 ]
      [ diam :/:diam 0 ];
  }
  # define resistances
  Process ExpressionAssignmentProcess( g )
  {
    StepperID  Default;
    Expression  "4*Ra.Value*dx.Value/(PI.Value*diam.Value*diam.Value)";
    VariableReferenceList
      [ g :/:g 1 ]
      [ Ra :/:Ra 0 ]
      [ dx :/:dx 0 ]
      [ PI :/:PI 0 ]
      [ diam :/:diam 0 ];
  }



  # solve cable equation
  # cable()?
  
  Process ExpressionAssignmentProcess( icat )
  {
    StepperID  Default;
    Expression  "icat_alpha1G.Value+icat_alpha1H.Value+icat_alpha1I.Value";
    VariableReferenceList
      [ icat :/:icat 1 ]
      [ icat_alpha1G :/:icat_alpha1G 0 ]
      [ icat_alpha1H :/:icat_alpha1H 0 ]
      [ icat_alpha1I :/:icat_alpha1I 0 ];
  }
  Process ExpressionAssignmentProcess( ica )
  {
    StepperID  Default;
    Expression  "icat.Value + ican.Value + ical.Value";
    VariableReferenceList
      [ ica :/:ica 1 ]
      [ icat :/:icat 0 ]
      [ ican :/:ican 0 ]
      [ ical :/:ical 0 ];
  }
  Process ExpressionAssignmentProcess( ion )
  {
    StepperID  Default;
    Expression  "ina11.Value+icat.Value+ican.Value+ical.Value+ikdr.Value+ika.Value+ikm.Value+ikc.Value+ikahp.Value+ipas.Value";
    VariableReferenceList
      [ ion :/:ion 1 ]
      [ ina11 :/:ina11 0 ]
      [ icat :/:icat 0 ]
      [ ican :/:ican 0 ]
      [ ical :/:ical 0 ]
      [ ikdr :/:ikdr 0 ]
      [ ika :/:ika 0 ]
      [ ikm :/:ikm 0 ]
      [ ikc :/:ikc 0 ]
      [ ikahp :/:ikahp 0 ]
      [ ipas :/:ipas 0 ];
  }
  #  Process ExpressionAssignmentProcess( current )
  #  {
    #  StepperID  Default;
    #  Expression  "ion.Value";
    #  VariableReferenceList
      #  [ current :/: 1 ]
      #  [ ion :/: 0 ];
  #  }
  # inject stimulation current at soma
  Process ExpressionAssignmentProcess( current ) # (mA/cm^2)
  {
    StepperID  Default;
    Expression  "ion.Value+Ist.Value";
    VariableReferenceList
      [ current :/:current 1 ]
      [ ion :/:ion 0 ]
      [ Ist :/:Ist 0 ];
  }
  Process ExpressionFluxProcess( v )
  {
    StepperID  Default;
    Expression  "-1.0*current.Value/cm.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ current :/:current 0 ]
      [ cm :/:cm 0 ];
  }



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
    Expression  "lt(t.Value,dt.Value)*(-65)+geq(t.Value,dt.Value)*cat_human_alpha1G_vv.Value";
    VariableReferenceList
      [ cat_human_alpha1G_vv :/:cat_human_alpha1G_vv 1 ]
      [ t :/:t 0 ]
      [ dt :/:dt 0 ];
  }
  Process ExpressionAssignmentProcess ( cat_human_alpha1G_n_inf )
  {
    StepperID  Default;
    Expression  "1/(1+exp(-(v.Value-cat_human_alpha1G_vhalfn.Value)/cat_human_alpha1G_kn.Value))";
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
    Expression  "(cat_human_alpha1G_n_inf.Value/cat_human_alpha1G_tau_n.Value)/(1/cat_human_alpha1G_tau_n.Value)";
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
    StepperID  Default;
    Expression  "-0.001*cat_human_alpha1G_z.Value*F.Value*(cao.Value-cai.Value*exp(cat_human_alpha1G_w.Value))*cat_human_alpha1G_w.Value/(exp(cat_human_alpha1G_w.Value)-1)";
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


  #  Kc channel (Ca-dependent k channel)
  #  From Migliore et al. 1995. J Neurophysiology

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



}