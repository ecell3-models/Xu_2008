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
  # define constant parameters
  
  # Farady constant (coulomb/mol)
  Variable Variable( F )
  {
    Value  96520; #1
  }
  
  # gas constant (J/K.mol)
  Variable Variable( R )
  {
    Value  8.3134; #2
  }
  
  Variable Variable( PI )
  {
    Value  3.14; #3
  }
  
  Variable Variable( celsius )
  {
    Value  30; #4
  }
  
  # absolute temperature (K)
  Variable Variable( T )
  {
    # celsius+273.14
    Value 303.14; #5
   }
    
  #define membrane properties
  
  Variable Variable( Rm )
  {
    Value  60000; #6
  }

  # units
  Variable Variable( cm )
  {
    Value  @(1.0*1.0e-3); #7
  }

  # units
  Variable Variable( Ra )
  {
    Value  @(200*1.0e-4); #8
  }

  # (mv)
  Variable Variable( vrest )
  {
    Value  -65; #9
  }
  
  Variable Variable( vinit )
  {
    # vinit = vrest
    Value  -65; #10
  }
  
  Variable Variable( vk )
  {
    Value  -91; #11
  }
  
  Variable Variable( vna )
  {
    Value  50; #12
  }

  # define initial ionic concentration
  
  # (Mv)
  Variable Variable( cai_init )
  {
    Value  5.0e-5; #13
  }
  
  # (Mv)
  Variable Variable( cao )
  {
    Value  2; #14
  }

  # Membrane voltage
  Variable Variable( v )
  {
    Value -65.0; #15
  }

  # dt?
  Variable Variable( dt )
  {
    Value  1; #16
  }

  # t?
  Variable Variable( t )
  {
    Value  1; #17
  }

  #define ionic conductances (S/cm^2)
  
  Variable Variable( gna11 )
  {
    Value  2.0; #18
  }
  
  Variable Variable( gcatbar )
  {
    Value  0.45; #19
  }
  
  Variable Variable( gcat31 )
  {
    Value  0.45; #20
  }
  
  Variable Variable( gcat32 )
  {
    Value  0.45; #21
  }
  
  Variable Variable( gcat33 )
  {
    Value  0.45; #22
  }
  
  Variable Variable( gcatbar_C4565 )
  {
    Value  @( 1.6*0.45 ); #23
  }
  
  Variable Variable( gcanbar )
  {
    Value  0.0025; #24
  }
  
  Variable Variable( gcalbar )
  {
    Value  0.0025; #25
  }
  
  Variable Variable( gkdr )
  {
    Value  0.08; #26
  }
  
  Variable Variable( gka )
  {
    Value  0.0001; #27
  }
  
  Variable Variable( gkm )
  {
    Value  0.00002; #28
  }
  
  Variable Variable( gkc )
  {
    Value  0.00005; #29
  }
  
  Variable Variable( gkahp )
  { # tmp
    Value  0.0000018; #30
  }
  
  Variable Variable( gpas )
  {
    # Value  1/Rm
    Value  @(1.0/60000); #31
  }

  #  define ionic concentration  & currents
  #  記録用では？
  #  全体をコメントアウトする?
  Variable Variable( cai )
  { 
    Value  5.0e-5;  #32  mM
  }
  Variable Variable( ina )
  { Value 0; #33, tmp
  }
  Variable Variable( ina11 )
  { Value 0; #34, tmp
  }
  Variable Variable( icat )
  { Value 0; #35, tmp
  }
  Variable Variable( icat_alpha1G )
  { Value 0; #36, tmp
  }
  Variable Variable( icat_alpha1H )
  { Value 0; #37, tmp
  }
  Variable Variable( icat_alpha1I )
  { Value 0; #38, tmp
  }
  Variable Variable( iC4565 )
  { Value 0; #39, tmp
  }
  Variable Variable( ican )
  { Value 0; #40, tmp
  }
  Variable Variable( ical )
  { Value 0; #41, tmp
  }
  Variable Variable( ica )
  { Value 0; #42, tmp
  }
  Variable Variable( ikdr )
  { Value 0; #43, tmp
  }
  Variable Variable( ika )
  { Value 0; #44, tmp
  }
  Variable Variable( ikm )
  { Value 0; #45, tmp
  }
  Variable Variable( ikc )
  { Value 0; #46, tmp
  }
  Variable Variable( ikahp )
  { Value 0; #47, tmp
  }
  Variable Variable( ipas )
  { Value 0; #48, tmp
  }
  Variable Variable( ion )
  { Value 0; #49, tmp
  }
  Variable Variable( current )
  { Value 0; #50, tmp
  }
  Variable Variable( Ist )
  { Value 0; #51, tmp   
  }

  # gating variables
  
  # Na1.1 gates
  Variable Variable( Na_MC3 )
  { Value 0; #52, tmp
  }
  Variable Variable( Na_MC )
  { Value 0; #53, tmp
  }
  Variable Variable( Na_MO )
  { Value 0; #54, tmp
  }
  Variable Variable( Na_MI )
  { Value 0; #55, tmp
  }
  Variable Variable( Na_MIs )
  { Value 0; #56, tmp
  }
  Variable Variable( Na_MC2 )
  { Value 0; #57, tmp
  }
  Variable Variable( IC3 )
  { Value 0; #58, tmp
  }
  Variable Variable( IC2 )
  { Value 0; #59, tmp
  }
  Variable Variable( Na_MIs2 )
  { Value 0; #60, tmp
  }
  Variable Variable( M_C3 )
  { Value 0; #61, tmp
  }
  Variable Variable( M_C2 )
  { Value 0; #62, tmp
  }
  Variable Variable( M_C )
  { Value 0; #63, tmp
  }
  Variable Variable( M_O )
  { Value 0; #64, tmp
  }
  Variable Variable( M_OP )
  { Value 0; #65, tmp
  }
  Variable Variable( Na_OP )
  { Value 0; #66, tmp
  }
  Variable Variable( Na_O )
  { Value 0; #67, tmp
  }
  Variable Variable( OPs )
  { Value 0; #68, tmp
  }
  Variable Variable( M_IF )
  { Value 0; #69, tmp
  }
  Variable Variable( ina11_wt )
  { Value 0.0; #70
  }
  Variable Variable( ina11_mt )
  { Value 0.0; #71
  }

#ducky

  # Ca N and L type channel gates  3Variables 
  Variable Variable( mn )
  { Value 0; #72, tmp
  }
  Variable Variable( hn )
  { Value 0; #73, tmp
  }
  Variable Variable( ml )
  { Value 0; #74, tmp
  } 
  # CaT gates
  Variable Variable( nth )
  { Value 0; #75, tmp
  }
  Variable Variable( lth )
  { Value 0; #76, tmp
  }
  Variable Variable( ntg )
  { Value 0; #77, tmp
  }
  Variable Variable( ltg )
  { Value 0; #78, tmp
  }
  Variable Variable( nti )
  { Value 0; #79, tmp
  }
  Variable Variable( lti )
  { Value 0; #80, tmp
  }
  # CaT mutant gates
  Variable Variable( ntC4565 )
  { Value 0; #81, tmp
  }
  Variable Variable( ltC4565 )
  { Value 0; #82, tmp
  }
  # K gates
  Variable Variable( nkdr )
  { Value 0; #83, tmp
  }
  Variable Variable( lkdr )
  { Value 0; #84, tmp
  }
  Variable Variable( nka )
  { Value 0; #85, tmp
  }
  Variable Variable( lka )
  { Value 0; #86, tmp
  }
  Variable Variable( mkm )
  { Value 0; #87, tmp
  }
  Variable Variable( okc )
  { Value 0; #88, tmp
  }
  Variable Variable( wkahp )
  { Value 0; #89, tmp
  }



  # gloable variables
  # segment number from 1: number of segments
  Variable Variable( seg )
  { Value 0; #90, tmp
  }



  # geometry parameters
  Variable Variable( area )
  { Value 0; #91, tmp
  }
  Variable Variable( diam )
  { Value 0; #92, tmp
  }
  Variable Variable( dx )
  { Value 0; #93, tmp
  }
  Variable Variable( g )
  { Value 0; #94, tmp
  }



  #  [Ca2+] dynamics using a simplified form
  #  ca_dyn

  Process ExpressionFluxProcess( cai ) #P1
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
    Value  15; #95
  }
  Variable Variable( L3 )
  {
    Value  25.5; #96
  }

  #  define segment length, diameter, area assumng dx = 1, and resistances
  Process ExpressionAssignmentProcess( diam ) #P2
  {
    StepperID  Default;
    Expression  "2.0*r3.Value";
    VariableReferenceList
      [ diam :/:diam 1 ]
      [ r3 :/:r3 0 ];
  }
  Process ExpressionAssignmentProcess( dx ) #P3
  {
    StepperID  Default;
    Expression  "L3.Value/1.0";
    VariableReferenceList
      [ dx :/:dx 1 ]
      [ L3 :/:L3 0 ];
  }
  Process ExpressionAssignmentProcess( area ) #P4
  {
    StepperID  Default;
    Expression  "PI.Value*diam.Value";
    VariableReferenceList
      [ area :/:area 1 ]
      [ PI :/:PI 0 ]
      [ diam :/:diam 0 ];
  }
  # define resistances
  Process ExpressionAssignmentProcess( g ) #P5
  {
    StepperID  Default;
    Expression  "4.0 * Ra.Value*dx.Value/(PI.Value*diam.Value*diam.Value)";
    VariableReferenceList
      [ g :/:g 1 ]
      [ Ra :/:Ra 0 ]
      [ dx :/:dx 0 ]
      [ PI :/:PI 0 ]
      [ diam :/:diam 0 ];
  }



  # solve cable equation
  # cable()?
  
  Process ExpressionAssignmentProcess( icat ) #P6
  {
    StepperID  Default;
    Expression  "icat_alpha1G.Value+icat_alpha1H.Value+icat_alpha1I.Value";
    VariableReferenceList
      [ icat :/:icat 1 ]
      [ icat_alpha1G :/:icat_alpha1G 0 ]
      [ icat_alpha1H :/:icat_alpha1H 0 ]
      [ icat_alpha1I :/:icat_alpha1I 0 ];
  }
  Process ExpressionAssignmentProcess( ica ) #P7
  {
    StepperID  Default;
    Expression  "icat.Value + ican.Value + ical.Value";
    VariableReferenceList
      [ ica :/:ica 1 ]
      [ icat :/:icat 0 ]
      [ ican :/:ican 0 ]
      [ ical :/:ical 0 ];
  }
  Process ExpressionAssignmentProcess( ion ) #P8
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

  # inject stimulation current at soma
  Process ExpressionAssignmentProcess( current ) #P9, (mA/cm^2)
  {
    StepperID  Default;
    Expression  "ion.Value+Ist.Value";
    VariableReferenceList
      [ current :/:current 1 ]
      [ ion :/:ion 0 ]
      [ Ist :/:Ist 0 ];
  }
  Process ExpressionFluxProcess( v ) #P10
  {
    Priority -5;
  
    StepperID  Default;
    Expression  "-1.0*current.Value/cm.Value";
    VariableReferenceList
      [ v :/:v 1 ]
      [ current :/:current 0 ]
      [ cm :/:cm 0 ];
  }

  @include('CaT.em')
  @#include('N-channel.em')
  @#include('L-channel.em')
  @#include('Ka-channel.em')
  @#include('Km-channel.em')
  @#include('Kc-channel.em')
  @#include('Kahtp.em')
}