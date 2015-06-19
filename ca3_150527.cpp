./*  Cell model: CA3 hippocampal neuron
 *
 *  Created by jun xu @ Clancy Lab of Cornell University Medical College on 3/27/05
 *  
 *  Geometry: single-compartment model modified on 04/19/07 */ 

#include <iostream>
#include <cmath>
#include <cstdlib>
#include <cstdio>
#include <iomanip>
#include "nr.h"
using namespace std;
#define nseg 1 

	/* Creation of Data File */
	    FILE *out_one;
	    void data_file ();	
	    int printdata;	// printing counter
	    int printval;  // intervals to output results	

// define constant parameters
        double F = 96520; // Farady constant (coulomb/mol)
        double R = 8.3134; // gas constant (J/K.mol)
        double PI = 3.14;
        double celsius = 30;
        double T = celsius+273.14;  // absolute temperature (K)

// define membrane properties
        double Rm = 60000; // 
        double cm = 1.0*1.0e-3; //units
        double Ra = 200*1.0e-4; //units
        double vrest = -65; // (mv)
        double vinit = vrest;
        double vk = -91;
        double vna = 50;
        

// define initial ionic concentration
        double cai_init = 5.0e-5; // (mM)
        double cao = 2; // (mM)

//	cout<<"ok"<<endl;

	/* Voltage */
	    double v[nseg];       // Membrane voltage 

	/* Time and spatial Step */
	    double dt;      // Time step 
        double t;       // Time 

// define ionic conductances (S/cm^2)
        double gna11 = 2.0;
        double gcatbar =0.45;    //0.45
        double gcat31 = 0.45;    //0.45
        double gcat32 = 0.45;    //0.45
        double gcat33 = 0.45;    //0.45
        double gcatbar_C4565 = 1.6*0.45;
        double gcanbar = 0.0025;
        double gcalbar = 0.0025;
        double gkdr =0.08;  // 0.08
        double gka =0.0001;
        double gkm =0.00002;
        double gkc =0.00005;  
        double gkahp =0.0000018;  // 0.0000018 testing
        double gpas = 1/Rm;

// define ionic concentration  & currents
        double cai[nseg];
        double ina[nseg], ina11[nseg];
	    double icat[nseg],icat_alpha1G[nseg],icat_alpha1H[nseg],icat_alpha1I[nseg];
        double iC4565[nseg];
        double ican[nseg],ical[nseg],ica[nseg];
        double ikdr[nseg],ika[nseg],ikm[nseg],ikc[nseg],ikahp[nseg],ipas[nseg];
        double ion[nseg],current[nseg];
        double Ist;

// gating variables
// Na1.1 gates
       double Na_MC3[nseg], Na_MC[nseg], Na_MO[nseg], Na_MI[nseg];
       double Na_MIs[nseg], Na_MC2[nseg], IC3[nseg], IC2[nseg]; 
       double Na_MIs2[nseg], M_C3[nseg], M_C2[nseg], M_C[nseg], M_O[nseg]; 
       double M_OP[nseg], Na_OP[nseg], Na_O[nseg], OPs[nseg], M_IF[nseg];

double ina11_wt = 0.0;
double ina11_mt = 0.0;

// Ca N and L type channel gates
       double mn[nseg],hn[nseg],ml[nseg];

// CaT gates
       double nth[nseg],lth[nseg],ntg[nseg],ltg[nseg],nti[nseg],lti[nseg];

// CaT mutant gates
       double ntC4565[nseg],ltC4565[nseg];
     
// K gates
       double nkdr[nseg],lkdr[nseg],nka[nseg],lka[nseg],mkm[nseg],okc[nseg],wkahp[nseg];       

// gloable variables
       int seg; // segment number from 1: number of segments
// geometry parameters
       double area[nseg], diam[nseg], dx[nseg], g[nseg];

void WT_SCN1A_function ();
void cat_human_alpha1G();
void cat_human_alpha1H();
void cat_human_alpha1I();
void C4565();
void can();
void cal();
void kdr();
void ka();
void km();
void kc();
void kahp_new();
void pas();
void ca_dyn();
void geo();
void cable();

int main()
{
	/* Opening of Datafiles */
	out_one = fopen("out_one", "w");
	printdata = 50;
	printval = 10;

	t = 0.0;        
    double tstop = 200;
    dt = 0.01;

    for(int i = 0; i<= nseg-1; i++)
    {
      v[i] = vrest;
      cai[i] = cai_init;
     }

// define neuron geometry: CA3 neuron
	
	geo();

	/* Beginning of Time Loop */
	for ( t = 0.0; t <= tstop; t+=dt)
	{
          if(t>=2 && t <= 7)
          {
          Ist = -0.2*100/(PI*diam[0]*dx[0]); //(mA/cm^2)
//         Ist = 0.0; // testing
          }
          else
          Ist = 0.0;

         // calculate ionic currents
          for(seg = 0; seg <= nseg-1; seg++) 
          {
		        WT_SCN1A_function ();
                cat_human_alpha1G();
                cat_human_alpha1H();
                cat_human_alpha1I();
                C4565();
                cal();
                can();
                kdr();
                ka();
                km();
                kc();
                kahp_new();
                pas();
                ca_dyn();
// debugging
/*   cout << "segment ######################################  " << seg << endl;
   cout << " The time is at ------------------------------  "<< t << endl;
   cout << v[seg] << endl;
   cout << ina[seg]<<endl;
   cout << icat[seg]<<endl;
   cout << ican[seg]<<endl;
   cout << ical[seg]<<endl;
   cout << ikdr[seg]<<endl;
   cout << ika[seg]<<endl;
   cout << ikm[seg]<<endl;
   cout << ikc[seg]<<endl;
   cout << ikahp[seg]<<endl;
   cout << ipas[seg]<<endl;
   cout << ica_pump[seg]<<endl;
   cout << cai[seg]<< endl;
*/
  
          }
    
        cable();

	// output results to a file at certain intervals
	    if(printdata >= printval) 
		{data_file();	
		printdata = 0;}
			
		printdata = printdata+1;

		cout << "t, v[0] = " << t << "     " << v[0] <<endl;

	}


	// indicate the end of the calculation: beeping
	cout << "\a\a"; 

	return (1);
}

// [Ca2+] dynamics using a simplified form

void ca_dyn()
{

  cai[0] = cai[0] +0.1*dt*(-0.15*ica[0]+(-cai[0])/5);

}

void data_file()
{
  fprintf(out_one,"%.3f\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\n", t, v[0],ina11[0],icat[0], ican[0], ical[0],icat_alpha1G[0],icat_alpha1H[0],icat_alpha1I[0],cai[0]);

}


// CA3 hippocampal neuron geometry (single-compartment model)
void geo() 
{
// define dimension
   double r3 = 15, L3 = 25.5; //soma

// define segment length, diameter, area assumng dx = 1, and resistances

   diam[0] = 2*r3;

   dx[0] = L3/1;

   area[0] = PI*diam[0];

// define resistances
   g[0] = 4*Ra*dx[0]/(PI*diam[0]*diam[0]);

}

//solve cable equation
void cable() 
{

  icat[0] = icat_alpha1G[0]+icat_alpha1H[0]+icat_alpha1I[0];
  ica[0] = icat[0] + ican[0] + ical[0];
  ion[0] = ina11[0]+icat[0]+ican[0]+ical[0]+ikdr[0]+ika[0]+ikm[0]+ikc[0]+ikahp[0]+ipas[0];
  current[0] = ion[0];


// inject stimulation current at soma
  current[0] = ion[0]+Ist; //(mA/cm^2)

  v[0] = v[0]-dt*current[0]/cm;

}


//**************************************************************************************
//	FUNCTION TO COMPUTE SCN1A NA CURRENT--Markov Model By Colleen Clancy @ Cornell U
//**************************************************************************************

void WT_SCN1A_function ()	
{	
	
//	Ena=(r*T/F)*log(Naout/Nain);

double a11, a12, a13, b11, b12, b13, a2, a3, a4, b4, b1, b2, b3, a5, b5, mu1, mu2, aa2, bb2, bb3, aa3;
double err1, err2, err3,err4, err5, err6, err7, err8, err9, err10, err11, err12, err13, err14; 

double  y1, z1,  x1, x2, y2, z2, e1, e2,  q1, q2,  w1, w2,  d1, d2, c1, c2, f1, j2, f2, tap1, tap2, jj1, u2, u1, p1, p2, t1, zz1, zz2;

double dny, dnz, dne1, dne, dne2, dny1, dnz1, dnx, dnx1,  dnq1, dnq,dnw, dnw1, dnd, 
 dnd1, dnc, dnc1, dnu, dnu1,  dnp, dnp1,  dntap, dntap1,  dnf1, dnj1, dnf, dnj, dnzz, dnzz1;

double qt = pow(2.0,(celsius-23.0)/10);

int i4;

 //Nain=10.0; 
 //Naout= 140.0;
//double ina;
			
int which_channels = 1;

if (which_channels ==1)   // WT rates
{
    a11= qt*2.802/(0.21*exp(-v[seg]/17.0)+0.23*exp(-v[seg]/150));
    a12= qt*2.802/(0.23*exp(-v[seg]/15.0)+0.25*exp(-v[seg]/150));
    a13= qt*2.802/(0.25*exp(-v[seg]/12.0)+0.27*exp(-v[seg]/150));
  

     b11= qt*0.4*exp(-v[seg]/20.3);
     b12= qt*0.4*exp(-(v[seg]-5)/20.3);
     b13= qt*0.4*exp(-(v[seg]-10)/20.3)/4.5;
     a3= qt*(3.7933e-7*exp(-v[seg]/7.6))*3;
     b3= qt*(0.0084+.00002*v[seg]);
    a2= qt*((9.178*exp(v[seg]/29.68))/4.5);
     b2= ((a13*a2*a3)/(b13*b3));	
     a4= (a2/100)*1.5;
      b4 = a3/5;
     a5= (a2/95000)*80.0;
      b5 = (a3/30)/10.0;

mu1= 0.0;
mu2= 0.0;


if (t<dt)
     {
     
ina11[seg] = 0.0;	
//initialize the Na+ current

//@-65
Na_MC3[seg]=0.438311;
Na_MO[seg]=2.1544e-6;
Na_MI[seg]=0.000187751;
Na_MIs[seg]=0.000501213;
Na_MC2[seg]=0.0125341;
IC3[seg]=0.527911;
IC2[seg]=0.0150964;
Na_MIs2[seg]=0.00529984;
M_C3[seg]=0;
M_C2[seg]=0;
M_C[seg]=0;
M_O[seg]=0;
M_IF[seg]=0;


   Na_MC[seg]= 1-(Na_MO[seg]+Na_MI[seg]+Na_MC2[seg]+Na_MC3[seg]+M_C3[seg]+Na_MIs[seg]
              +M_C2[seg]+M_C[seg]+M_O[seg]+IC3[seg]+IC2[seg]+Na_MIs2[seg]);
   Na_MC[seg] = 0.000155888;
        
 	}

} 

else if (which_channels ==2)   // RH rates
{
    a11= 2.802/(0.21*exp(-v[seg]/17.0)+0.23*exp(-v[seg]/150));
    a12= 2.802/(0.23*exp(-v[seg]/15.0)+0.25*exp(-v[seg]/150));
    a13= 2.802/(0.25*exp(-v[seg]/12.0)+0.27*exp(-v[seg]/150));
  

     b11= 0.4*exp(-v[seg]/20.3);
     b12= 0.4*exp(-(v[seg]-5)/20.3);
     b13= 0.4*exp(-(v[seg]-10)/20.3)/4.5;
     a3= (3.7933e-7*exp(-v[seg]/7.6))*3;
     b3= (0.0084+.00002*v[seg]);
     a2= ((9.178*exp(v[seg]/29.68))/4.5);
     b2= ((a13*a2*a3)/(b13*b3));	
     
     a4= (a2/100)*1.5;
     b4 = a3/5;
      
     a5= (a2/95000)*80.0;
     b5 = (a3/30)/10.0;

// flicker inactivation rates

aa2= ((9.178*exp(v[seg]/29.68))/4.5);
bb3= (0.0084+.00002*v[seg]);
aa3= (3.7933e-7*exp(-v[seg]/7.7))*83;

bb2= ((a13*aa2*aa3)/(b13*bb3));

mu1= 2e-5;
mu2= 2e-4;


if (t<dt)
     {
     
ina11[seg] = 0.0;				//initialize the Na+ current

//@ -65mv

Na_MC3[seg]=0.419443;
Na_MO[seg]=2.06164e-6;
Na_MI[seg]=0.000179635;
Na_MIs[seg]=0.00050059;
Na_MC2[seg]=0.0119946;
IC3[seg]=0.505087;
IC2[seg]=0.0144437;
Na_MIs2[seg]=0.00509992;
M_C3[seg]=0.0418866;
M_C2[seg]=0.00119781;
M_C[seg]=1.4897e-5;
M_O[seg]=2.05662e-7;
M_IF[seg]=7.12628e-7;


   Na_MC[seg]= 1-(Na_MO[seg]+Na_MI[seg]+Na_MC2[seg]+Na_MC3[seg]+M_C3[seg]
               +Na_MIs[seg]+M_C2[seg]+M_C[seg]+M_O[seg]+IC3[seg]+IC2[seg]+Na_MIs2[seg]+M_IF[seg]);
   
        
 	}

} 


/*  	if (t>=60000.0-dt&&Get_steady_state==1)
 	{
 	
 	cout<<"Na_MC3="<<Na_MC3<<";"<<endl;
 	cout<<"Na_MO="<<Na_MO<<";"<<endl;
 	cout<<"Na_MI="<<Na_MI<<";"<<endl;
 	cout<<"Na_MIs="<<Na_MIs<<";"<<endl;
 	cout<<"Na_MC2="<<Na_MC2<<";"<<endl;
 	cout<<"IC3="<<IC3<<";"<<endl;
 	cout<<"IC2="<<IC2<<";"<<endl;
	cout<<"Na_MIs2="<<Na_MIs2<<";"<<endl;
 	
 	cout<<"M_C3="<<M_C3<<";"<<endl;
 	cout<<"M_C2="<<M_C2<<";"<<endl;
 	cout<<"M_C="<<M_C<<";"<<endl;
 	cout<<"M_O="<<M_O<<";"<<endl;
        cout<<"M_IF="<<M_IF<<";"<<endl;
 	
 	exit (0);
 	}
        
*/  
   
 if (t>=dt)
   {	
     y1=Na_MO[seg];     z1=Na_MI[seg];	x1= Na_MC2[seg];	q1= Na_MC3[seg];	w1= Na_MIs[seg];
     d1= M_C3[seg]; 	   c1= M_C2[seg];	u1= M_C[seg];	p1= M_O[seg];	tap1= Na_MC[seg];
     jj1= IC3[seg];	   f1= IC2[seg];	e1 = Na_MIs2[seg];	zz1= M_IF[seg];
     
     
     //UPPER STATES

     Na_MC[seg]= 1-(Na_MO[seg]+Na_MI[seg]+Na_MC2[seg]+Na_MC3[seg]+M_C3[seg]
                 +Na_MIs[seg]+M_C2[seg]+M_C[seg]+M_O[seg]+IC3[seg]+IC2[seg]+Na_MIs2[seg]+M_IF[seg]);
     
     dny=((Na_MC[seg]*a13+Na_MI[seg]*b2+M_O[seg]*mu2)- (Na_MO[seg]*(b13+a2+mu1)))*dt;
     dnz=((IC2[seg]*a12+Na_MO[seg]*a2+Na_MC[seg]*b3+Na_MIs[seg]*b4)- (Na_MI[seg]*(b2+a3+a4+b12)))*dt;
     dnx= ((IC2[seg]*a3+Na_MC[seg]*b12+Na_MC3[seg]*a11+M_C2[seg]*mu2)-(Na_MC2[seg]*(a12+b11+mu1+b3)))*dt;
     dnq= (IC3[seg]*a3+Na_MC2[seg]*b11+M_C3[seg]*mu2-(Na_MC3[seg]*(a11+mu1+b3)))*dt;
     dnw= ((Na_MI[seg]*a4+Na_MIs2[seg]*b5)-Na_MIs[seg]*(b4+a5))*dt;
//     dntap= (Na_MC2[seg]*a12+Na_MO[seg]*b13+M_C[seg]*mu2+Na_MI[seg]*a3-(Na_MC[seg]*(a13+b12+mu1+b3)))*dt;
     dnj= ((Na_MC3[seg]*b3+IC2[seg]*b11)-IC3[seg]*(a11+a3))*dt;
     dnf= ((Na_MC2[seg]*b3+IC3[seg]*a11+Na_MI[seg]*b12)-IC2[seg]*(a12+b11+a3))*dt;
     dne= (Na_MIs[seg]*a5-Na_MIs2[seg]*b5)*dt;
     
     //LOWER STATES
     dnd= (Na_MC3[seg]*mu1+M_C2[seg]*b11-(M_C3[seg]*(a11+mu2)))*dt;
     dnc=  (Na_MC2[seg]*mu1+M_C3[seg]*a11+M_C[seg]*b12-(M_C2[seg]*(a12+mu2+b11)))*dt;
     dnu= (Na_MC[seg]*mu1+M_C2[seg]*a12+M_O[seg]*b13+M_IF[seg]*aa3-(M_C[seg]*(a13+mu2+b12+bb3)))*dt;
     dnp= ((M_C[seg]*a13+Na_MO[seg]*mu1+M_IF[seg]*bb2)-(M_O[seg]*(b13+mu2+aa2)))*dt;
     dnzz= ((M_O[seg]*aa2+M_C[seg]*bb3)- (M_IF[seg]*(bb2+aa3)))*dt;
     
//   cout<<dny+dnz+dnx+dnq+dnw+dntap+dnj+dnf+dnd+dnc+dnu+dnp+dne+dnzz<<endl; 		//Use this as a test that derivatives sum to zero
     
     
    y2=Na_MO[seg]+dny;
    z2=Na_MI[seg]+dnz;
    x2= Na_MC2[seg]+dnx;
    q2= Na_MC3[seg]+dnq;
    w2= Na_MIs[seg]+dnw;
//    tap2 = Na_MC[seg]+dntap;
    j2= IC3[seg]+dnj;
    f2= IC2[seg]+dnf;
    e2 = Na_MIs2[seg]+dne;
    
    d2= M_C3[seg]+dnd;
    c2= M_C2[seg]+dnc;
    u2= M_C[seg]+dnu;
    p2= M_O[seg]+dnp;
    zz2= M_IF[seg]+dnzz;
       
    
   
    
  // Na_MC[seg]= 1-(y2+z2+x2+q2+w2+d2+c2+u2+p2);

err1= y2-y1;	err2= z2-z1;	err3=x2-x1;  	err10= 0.0;
err4= q2-q1;	err5= w2-w1;	err6=d2-d1;	err11= j2-jj1;
err7= c2-c1;	err8= u2-u1;	err9= p2-p1;	err12= f2- f1;
err13= e2-e1;	err14= zz2-zz1;

	dny1= dny;
	dnz1=dnz;
	dnx1= dnx;		//UPPER STATES
	dnq1= dnq;
	dnw1=dnw;
//	dntap1=dntap;
	dnj1= dnj;
	dnf1= dnf;
	dne1= dne;
	
	
	dnd1= dnd;
	dnc1= dnc;		//LOWER STATES
	dnu1= dnu;
	dnp1= dnp;
        dnzz1= dnzz;
	
i4=0;

//cout << "testing is ok" << endl;

while (((err1>1e-5)||(err1<-1e-5)||(err2>1e-5)||(err2<-1e-5)||(err3>1e-5)
||(err3<-1e-5)||(err4>1e-5)||(err4<-1e-5)||(err5>1e-5)||(err5<-1e-5)||
(err6>1e-5)||(err6<-1e-5)||(err7>1e-5)||(err7<-1e-5)||(err8>1e-5)||
(err8<-1e-5)||(err9>1e-5)||(err9<-1e-5)||(err10>1e-5)||(err10<-1e-5)||
(err11>1e-5)||(err11<-1e-5)||(err12>1e-5)||(err12<-1e-5)||(err13>1e-5)||(err13<-1e-5)||(err14>1e-5)||(err14<-1e-5))
&&(i4<40))
 {
	y1=y2; 	 	z1=z2;	 	 x1=x2;		q1=q2;		w1= w2;
	d1= d2;		c1= c2;		u1= u2;		p1= p2;    //	tap1= tap2;
	jj1= j2;	f1= f2;		e1= e2;		zz1= zz2;

    tap1 = 1-y1-z1-x1-q1-w1-d1-c1-u1-p1-jj1-f1-e1-zz1;
	
    dny=((tap1*a13+z1*b2+p1*mu2)- (y1*(b13+a2+mu1)))*dt;
    dnz=((f1*a12+y1*a2+tap1*b3+w1*b4)- (z1*(b2+a3+a4+b12)))*dt;
    dnx=  (((f1*a3+tap1*b12+q1*a11+c1*mu2)-(x1*(a12+b11+mu1+b3)))*dt);
    dnq= ((jj1*a3+x1*b11+d1*mu2-q1*(a11+mu1+b3))*dt);
    dnw= ((z1*a4+e1*b5)-w1*(b4+a5))*dt;
//    dntap= (x1*a12+y1*b13+u1*mu2+z1*a3-(tap1*(a13+b12+mu1+b3)))*dt;
    dnj= ((q1*b3+f1*b11)-jj1*(a11+a3))*dt;
    dnf= ((x1*b3+jj1*a11+z1*b12)-f1*(a12+b11+a3))*dt;
    dne= (w1*a5- e1*b5)*dt;
    
  // cout<<dntap<<setw(15)<<t<<endl;
    
    
    dnd= (q1*mu1+c1*b11-(d1*(a11+mu2)))*dt;
    dnc= (x1*mu1+d1*a11+u1*b12-(c1*(a12+mu2+b11)))*dt;
    dnu= (tap1*mu1+c1*a12+p1*b13+zz1*aa3-(u1*(a13+mu2+b12+bb3)))*dt;
    dnp= (u1*a13+y1*mu1+zz1*bb2-(p1*(mu2+b13+aa2)))*dt;
    dnzz= (p1*aa2+u1*bb3-(zz1*(aa3+bb2)))*dt;
    
    
    
    dny= (dny+dny1)/2;
    dnz= (dnz+dnz1)/2;
    dnx= (dnx+dnx1)/2;
    dnq= (dnq+dnq1)/2;
    dnw= (dnw+dnw1)/2;
//    dntap= (dntap+dntap1)/2;
    dnj= (dnj+dnj1)/2;
    dnf= (dnf+dnf1)/2;
    dne= (dne+dne1)/2;
    
    dnd= (dnd+dnd1)/2;
    dnc= (dnc+dnc1)/2;
    dnu= (dnu+dnu1)/2;
    dnp= (dnp+dnp1)/2;
    dnzz= (dnzz+dnzz1)/2;
    
     y2= Na_MO[seg]+dny;
     z2= Na_MI[seg]+dnz;
     x2= Na_MC2[seg]+dnx;
     q2= Na_MC3[seg]+dnq;
     w2= Na_MIs[seg]+dnw;
//     tap2= Na_MC[seg]+dntap;
     j2= IC3[seg]+dnj;
     f2= IC2[seg]+dnf;
     e2= Na_MIs2[seg]+dne;
     
     d2= M_C3[seg]+dnd;
     c2= M_C2[seg]+dnc;
     u2= M_C[seg]+dnu;
     p2= M_O[seg]+dnp;
     zz2= M_IF[seg]+dnzz;
     
     dny1=dny;
     dnz1=dnz;
     dnx1= dnx;
     dnq1=dnq;
     dnw1= dnw;
//     dntap1= dntap;
     dnf1= dnf;
     dnj1= dnj;
     dne1= dne;
     
     dnd1= dnd;
     dnc1= dnc;
     dnu1= dnu;
     dnp1= dnp;
     dnzz1= dnzz;
     
    // Na_MC[seg]= 1-(y2+z2+x2+q2+w2+d2+c2+u2+p2);
     
	err1=y2-y1;
 	err2= z2-z1;
 	err3= x2-x1;
 	err4= q2-q1;
 	err5= w2-w1;
 	err6= d2-d1;
 	err7= c2-c1;
 	err8= u2-u1;
 	err9= p2-p1;
 	err10= 0.0;
 	err11= j2-jj1;
 	err12= f2-f1;
 	err13= e2-e1;
        err14= zz2-zz1;
 	
 	i4++;
	
   
 }
 
 
 if (i4<40)	
    { 
   Na_MO[seg]=y2; 	 Na_MI[seg]=z2;	 Na_MC2[seg]= x2;	Na_MC3[seg]= q2;	Na_MIs[seg]=w2;
   M_C3[seg]= d2;   	 M_C2[seg]= c2;	 M_C[seg]= u2;	M_O[seg]= p2;    //	Na_MC[seg]=tap2;
   IC3[seg]= j2;	IC2[seg]=f2;		Na_MIs2[seg]= e2; 	M_IF[seg]= zz2;

   Na_MC[seg]= 1-(Na_MO[seg]+Na_MI[seg]+Na_MC2[seg]+Na_MC3[seg]+M_C3[seg]
               +Na_MIs[seg]+M_C2[seg]+M_C[seg]+M_O[seg]+IC3[seg]+IC2[seg]+Na_MIs2[seg]+M_IF[seg]);

// cout << "Na_Mc" << Na_MC[seg] << endl;
   
  //  Na_MC[seg]=1-(Na_MO[seg]+Na_MI[seg]+ Na_MC2[seg]+Na_MIs[seg]+Na_MC3[seg]+M_C3[seg]+M_C2[seg]+M_C[seg]+M_O[seg]);
  
    }
    
   
    
  else 
  { 
//   cout<<"error_ina"<<setw(15)<<i4<<setw(15)<<t<<endl;
   exit(0);
    }
  
    
  
   
   } 
    
   M_OP[seg]= Na_MO[seg]+M_O[seg];
   M_OP[seg]= (M_OP[seg]*1.0);
   Na_OP[seg]= Na_O[seg]*0;
    
   OPs[seg]= M_OP[seg]+Na_OP[seg];
   ina11[seg]= gna11*0.035*OPs[seg]*(v[seg]-50);

if(which_channels == 1)
  ina11_wt = ina11[seg];
else if (which_channels == 2)
  ina11_mt = ina11[seg];		
    
}



// Human T-type calcium channels based on Chemin et al., J Physiol., 2002, 540, 3-14.
// CaT--alpha 1G CaV3.1
void cat_human_alpha1G() {
   double n_inf,l_inf,tau_n,tau_l,vv;
   double gbar = 0.008; // s/cm2
   double vhalfn = -49.3;  //mv
   double vhalfl = -74.2;
   double kn = 4.6;
   double kl = -5.5;
   double q10 = 2.3;
   double qt = pow(q10,(celsius-28)/10);
   double pcabar = 0.0001; // cm/s
   double z= 2;
   if(t<dt) { 
      vv = -65;
      n_inf = 1/(1+exp(-(vv-vhalfn)/kn));
      l_inf = 1/(1+exp(-(vv-vhalfl)/kl));
              
      if(vv > -56)
      tau_n = (0.8+0.025*exp(-vv/14.5))/qt;
      else    
      tau_n = (1.71*exp((vv+120)/38))/qt;
              
      tau_l = (12.3+0.12*exp(-vv/10.8))/qt;
      ntg[seg] = n_inf;
      ltg[seg] = l_inf;
   }          
              
   n_inf = 1/(1+exp(-(v[seg]-vhalfn)/kn));
   l_inf = 1/(1+exp(-(v[seg]-vhalfl)/kl));
              
   if(v[seg]>-56)
   tau_n = (0.8+0.025*exp(-v[seg]/14.5))/qt;
   else       
   tau_n = (1.71*exp((v[seg]+120)/38))/qt;
   if(v[seg]>-60)
   tau_l = (12.3+0.12*exp(-v[seg]/10.8))/qt;
   else       
   tau_l = 137/qt; 
              
   ntg[seg] = (ntg[seg] + dt*n_inf/tau_n)/(1+dt/tau_n);
   ltg[seg] = (ltg[seg] + dt*l_inf/tau_l)/(1+dt/tau_l);
              
   double w = v[seg]*0.001*z*F/(R*(celsius+273.16));
   double ghk = -0.001*z*F*(cao-cai[seg]*exp(w))*w/(exp(w)-1);
   icat_alpha1G[seg] = gcat31*pcabar*ntg[seg]*ntg[seg]*ltg[seg]*ghk;
}            
// CaT--alpha 1H  CaV3.2
// based on Vitko et al., 2005, J Neurosci, 25, 4844-4855
// provided by Dr Edward Perez-Reyes on 6/30/05
void cat_human_alpha1H() {
   double n_inf,l_inf,tau_n,tau_l,vv;
   double gbar = 0.008; // s/cm2
   double vhalfn = -48.4;  //mv
   double vhalfl = -75.6;
   double kn = 5.2;
   double kl = -6.2;
   double q10 = 2.3;
   double qt = pow(q10,(celsius-28)/10);
   double pcabar = 0.0001; // cm/s
   double z= 2;

   if(t<dt) {
      vv = -65;
      n_inf = 1/(1+exp(-(vv-vhalfn)/kn));
      l_inf = 1/(1+exp(-(vv-vhalfl)/kl));

      if(vv > -56)
      tau_n = (1.34+0.035*exp(-vv/11.8))/qt;
      else
      tau_n = (2.44*exp((vv+120)/40))/qt;

      tau_l = (18.3+0.005*exp(-vv/6.2))/qt;

//      tau_n = (1.9+1.0/(exp((vv+21.0)/11.9)+exp(-(vv+115)/21)))/qt;
//      tau_l = (18.3+(1942+exp((vv+164)/9.2))/(1+exp((vv+89.3)/3.7)))/qt;

      nth[seg] = n_inf;
      lth[seg] = l_inf;
   }

      n_inf = 1/(1+exp(-(v[seg]-vhalfn)/kn));
      l_inf = 1/(1+exp(-(v[seg]-vhalfl)/kl));

      if(v[seg] > -56)
      tau_n = (1.34+0.035*exp(-v[seg]/11.8))/qt;
      else
      tau_n = (2.44*exp((v[seg]+120)/40))/qt;
     if(v[seg]>-60)
      tau_l = (18.3+0.005*exp(-v[seg]/6.2))/qt;
     else
      tau_l = 500/qt;
//      tau_n = (1.9+1.0/(exp((v+21.0)/11.9)+exp(-(v+115)/21)))/qt;
//      tau_l = (18.3+(1942+exp((v+164)/9.2))/(1+exp((v+89.3)/3.7)))/qt;

   nth[seg] = (nth[seg] + dt*n_inf/tau_n)/(1+dt/tau_n);
   lth[seg] = (lth[seg] + dt*l_inf/tau_l)/(1+dt/tau_l);

   double w = v[seg]*0.001*z*F/(R*(celsius+273.16));
   double ghk = -0.001*z*F*(cao-cai[seg]*exp(w))*w/(exp(w)-1);
   icat_alpha1H[seg] = gcat32*pcabar*nth[seg]*nth[seg]*lth[seg]*ghk;

}

// Ca3.2 mutant channel

void C4565() {
   double nC4565_inf,lC4565_inf,tauC4565_n,tauC4565_l, carev;
   double vhalfnC4565 = -59.36;  //mv
   double vhalflC4565 = -85.5;
   double knC4565 = 7.53;
   double klC4565 = -7.18;
   double knl = 1.143;
   double q10 = 2.3;
   double qt = pow(q10,(celsius-25)/10);
   double pcabar = 0.0001; // cm/s
   double z= 2;


   if(t<dt) {
      v[seg] = vinit;
      nC4565_inf = 1/(1+exp(-(v[seg]-vhalfnC4565)/knC4565));
      lC4565_inf = 1/(1+exp(-(v[seg]-vhalflC4565)/klC4565));
      tauC4565_n = (1.52+1.0/(exp((v[seg]+40.3)/10.06)+exp(-(v[seg]+144.3)/28.6)))/qt;
      tauC4565_l = (13.7+(1943+exp((v[seg]+164)/9.2))/(1+exp((v[seg]+89.3)/3.7)))/qt;
      ntC4565[seg] = nC4565_inf;
      ltC4565[seg] = lC4565_inf;
   }

      nC4565_inf = 1/(1+exp(-(v[seg]-vhalfnC4565)/knC4565));
      lC4565_inf = 1/(1+exp(-(v[seg]-vhalflC4565)/klC4565));
      tauC4565_n = (1.52+1.0/(exp((v[seg]+40.3)/10.06)+exp(-(v[seg]+144.3)/28.6)))/qt;
      tauC4565_l = (13.7+(1943+exp((v[seg]+164)/9.2))/(1+exp((v[seg]+89.3)/3.7)))/qt;

      ntC4565[seg] = (ntC4565[seg] + dt*nC4565_inf/tauC4565_n)/(1+dt/tauC4565_n);
      ltC4565[seg] = (ltC4565[seg] + dt*lC4565_inf/tauC4565_l)/(1+dt/tauC4565_l);

//   carev = (1e3)*(R*(celsius+273.15))/(2*F)*log(cao/cai[seg]);
//   iC4565[seg] = 0.0001*gcatbar_C4565*ntC4565[seg]*ntC4565[seg]*ltC4565[seg]*(v[seg]-carev);

   double w = v[seg]*0.001*z*F/(R*(celsius+273.16));
   double ghk = -0.001*z*F*(cao-cai[seg]*exp(w))*w/(exp(w)-1);
   iC4565[seg] = gcatbar_C4565*pcabar*ntC4565[seg]*ntC4565[seg]*ltC4565[seg]*ghk;

}


// CaT--alpha 1I CaV3.3
void cat_human_alpha1I() {
   double n_inf,l_inf,tau_n,tau_l,vv;
   double gbar = 0.008; // s/cm2
   double vhalfn = -41.5;  //mv
   double vhalfl = -69.8;
   double kn = 6.2;
   double kl = -6.1;
   double q10 = 2.3;
   double qt = pow(q10,(celsius-28)/10);
   double pcabar = 0.0001; // cm/s
   double z= 2;

   if(t<dt) {
      vv = -65;
      n_inf = 1/(1+exp(-(vv-vhalfn)/kn));
      l_inf = 1/(1+exp(-(vv-vhalfl)/kl));
//      tau_n = (9.3+8.0/(exp((vv+30.0)/11.9)+exp(-(vv+120)/21)))/qt;
//      tau_l = (13.7+(1942+exp((vv+164)/9.2))/(1+exp((vv+89.3)/3.7)))/qt;

      if(vv > -60)
      tau_n = (7.2+0.02*exp(-vv/14.7))/qt;
      else
      tau_n = (0.875*exp((vv+120)/41))/qt;
      if(vv>-70)
      tau_l = (79.5+2.0*exp(-vv/9.3))/qt;
      else
      tau_l = 260/qt;

      nti[seg] = n_inf;
      lti[seg] = l_inf;
   }

      n_inf = 1/(1+exp(-(v[seg]-vhalfn)/kn));
      l_inf = 1/(1+exp(-(v[seg]-vhalfl)/kl));

//      tau_n = (9.3+8.0/(exp((v+30.0)/11.9)+exp(-(v+120)/21)))/qt;
//      tau_l = (13.7+(1942+exp((v+164)/9.2))/(1+exp((v+89.3)/3.7)))/qt;

      if(v[seg] > -60)
        tau_n = (7.2+0.02*exp(-v[seg]/14.7))/qt;
      else
        tau_n = (0.875*exp((v[seg]+120)/41))/qt;
     if(v[seg]>-60)
      tau_l = (79.5+2.0*exp(-v[seg]/9.3))/qt;
     else
      tau_l = 260/qt;
      nti[seg] = (nti[seg] + dt*n_inf/tau_n)/(1+dt/tau_n);
      lti[seg] = (lti[seg] + dt*l_inf/tau_l)/(1+dt/tau_l);

      double w = v[seg]*0.001*z*F/(R*(celsius+273.16));
      double ghk = -0.001*z*F*(cao-cai[seg]*exp(w))*w/(exp(w)-1);
      icat_alpha1I[seg] = gcat33*pcabar*nti[seg]*nti[seg]*lti[seg]*ghk;

}


// N-channel

void can() {  //N-channel from Jaffe et al. 1994, J of Neurophisiology
              double am,bm,ah,bh,tau_m,tau_h,m_inf,h_inf;


              if(t<dt) {
                        v[seg] = -65;
                        am = 0.1967*(-v[seg]+19.88)/(exp((-v[seg]+19.88)/10)-1);
                        bm = 0.046*exp(-v[seg]/20.73);
                        ah = 1.6e-4*exp(-v[seg]/48.4);
                        bh = 1/(exp((-v[seg]+39)/10)+1);
                        tau_m = 1/(am+bm);
                        tau_h = 1/(ah+bh);
                        m_inf = am*tau_m;
                        h_inf = ah*tau_h;
                        mn[seg] = m_inf;
                        hn[seg] = h_inf;
                        ican[seg] = 0.0;
              }


              am = 0.1967*(-v[seg]+19.88)/(exp((-v[seg]+19.88)/10)-1);
              bm = 0.046*exp(-v[seg]/20.73);
              ah = 1.6e-4*exp(-v[seg]/48.4);
              bh = 1/(exp((-v[seg]+39)/10)+1);
              tau_m = 1/(am+bm);
              tau_h = 1/(ah+bh);
              m_inf = am*tau_m;
              h_inf = ah*tau_h;

              mn[seg] = (mn[seg] + dt*m_inf/tau_m)/(1+dt/tau_m);
              hn[seg] = (hn[seg] + dt*h_inf/tau_h)/(1+dt/tau_h);

             double ki = 0.001;
             double KTF = 25/293.15*(celsius+273.15);
             double f = KTF/2;
             double nu = v[seg]/f;
             double efun;
             if(fabs(nu)<1e-4)
             efun = 1-nu/2;
             else
             efun = nu/(exp(nu)-1);

             double ghk = -f*(1-cai[seg]/cao*exp(nu))*efun;
//             double gcanbar = 0.0003;
   
             double gcan = gcanbar*mn[seg]*mn[seg]*hn[seg]*ki/(ki+cai[seg]);

             ican[seg] = gcan*ghk;

//             return ican;

}

// L-channel

void cal() {  //L-channel Jaffe et al. 1994. J Neurophisiology
              double am,bm,tau_m,m_inf; 
              if(t<dt) {
              v[seg] = - 65;
              am = 15.69*(-v[seg]+81.5)/(exp((-v[seg]+81.5)/10)-1);
              bm = 0.29*exp(-v[seg]/10.86);
              tau_m = 1/(am+bm);
              m_inf = am*tau_m;
              ml[seg] = m_inf;
              ical[seg] = 0.0;
              }

              am = 15.69*(-v[seg]+81.5)/(exp((-v[seg]+81.5)/10)-1);
              bm = 0.29*exp(-v[seg]/10.86);
              tau_m = 1/(am+bm);
              m_inf = am*tau_m;

              ml[seg]= (ml[seg] + dt*m_inf/tau_m)/(1+dt/tau_m);

              double ki = 0.001;
//              double gcalbar = 0.003;
              double gcal = gcalbar*ml[seg]*ml[seg]*(ki/(ki+cai[seg]));
              double KTF = 25/293.15*(celsius+273.15);
              double f = KTF/2;
              double nu = v[seg]/f;
              double efun;
              if(fabs(nu) < 1e-4)
              efun = 1-nu/2;
              else
              efun = nu/(exp(nu)-1); 
     
              double ghk = -f*(1-cai[seg]/cao*exp(nu))*efun;

              ical[seg] = gcal*ghk;

//              return ical;

}

// K channels

// Kdr channel (Ca-independent k channel)

void kdr() { // From Migliore et al. 1995. J Neurophysiology

              double an,bn,al,bl,tau_n,tau_l,n_inf,l_inf;

              if(t<dt) {
                        v[seg] = -65;
                        an = 0.03*exp(1.e-3*5*0.4*(v[seg]+32)*F/(R*T));
                        bn = 0.03*exp(-1.e-3*5*0.6*(v[seg]+32)*F/(R*T));
                        al = 0.001*exp(-1.e-3*2*(v[seg]+61)*F/(R*T));
                        bl = 0.001;
                        tau_n = 1/(an+bn);
                        tau_l = 1/(al+bl);
                        n_inf = an*tau_n;
                        l_inf = al*tau_l;
                        nkdr[seg] = n_inf;
                        lkdr[seg] = l_inf;
                        ikdr[seg] = 0.0;
              }


              an = 0.03*exp(1.e-3*5*0.4*(v[seg]+32)*F/(R*T));
              bn = 0.03*exp(-1.e-3*5*0.6*(v[seg]+32)*F/(R*T));
              al = 0.001*exp(-1.e-3*2*(v[seg]+61)*F/(R*T));
              bl = 0.001;
              tau_n = 1/(an+bn);
              tau_l = 1/(al+bl);
              n_inf = an*tau_n;
              l_inf = al*tau_l;

              nkdr[seg] = (nkdr[seg] + dt*n_inf/tau_n)/(1+dt/tau_n);
              lkdr[seg] = (lkdr[seg] + dt*l_inf/tau_l)/(1+dt/tau_l);

              ikdr[seg] = gkdr*nkdr[seg]*nkdr[seg]*nkdr[seg]*lkdr[seg]*(v[seg]+91);

//             return ikdr;


}


// Ka channel (Ca-independent k channel)

void ka() { // From Migliore et al. 1995. J Neurophysiology

              double an,bn,al,bl,tau_n,tau_l,n_inf,l_inf;

              if(t<dt) {
                        v[seg] = -65;
                        an = 0.02*exp(1.e-3*3*0.6*(v[seg]+33.6)*F/(R*T));
                        bn = 0.02*exp(-1.e-3*1.2*(v[seg]+33.6)*F/(R*T));
                        al = 0.08*exp(-1.e-3*4*(v[seg]+83)*F/(R*T));
                        bl = 0.08;
                        tau_n = 1/(an+bn);
                        tau_l = 1/(al+bl);
                        n_inf = an*tau_n;
                        l_inf = al*tau_l;
                        nka[seg] = n_inf;
                        lka[seg] = l_inf;
                        ika[seg] = 0.0;
              }


              an = 0.02*exp(1.e-3*3*0.6*(v[seg]+33.6)*F/(R*T));
              bn = 0.02*exp(-1.e-3*1.2*(v[seg]+33.6)*F/(R*T));
              al = 0.08*exp(-1.e-3*4*(v[seg]+83)*F/(R*T));
              bl = 0.08;
              tau_n = 1/(an+bn);
              tau_l = 1/(al+bl);
              n_inf = an*tau_n;
              l_inf = al*tau_l;

              nka[seg] = (nka[seg] + dt*n_inf/tau_n)/(1+dt/tau_n);
              lka[seg] = (lka[seg] + dt*l_inf/tau_l)/(1+dt/tau_l);

              ika[seg] = gka*nka[seg]*lka[seg]*(v[seg]+91.0);

//             return ika;

}


// Km channel (Ca-independent k channel)

void km() { // From Migliore et al. 1995. J Neurophysiology

              double am,bm,tau_m,m_inf,q10;
              q10 = pow(5.0,((celsius-23)/10));

              if(t<dt) {
                        v[seg] = -65;
                        am = q10*0.006*exp(1.e-3*10*0.06*(v[seg]+55)*F/(R*T));
                        bm = q10*0.006*exp(-1.e-3*9.4*(v[seg]+55)*F/(R*T));
                        tau_m = 1/(am+bm);
                        m_inf = am*tau_m;
                        mkm[seg] = m_inf;
                        ikm[seg] = 0.0;
              }


              am = q10*0.006*exp(1.e-3*10*0.06*(v[seg]+55)*F/(R*T));
              bm = q10*0.006*exp(-1.e-3*9.4*(v[seg]+55)*F/(R*T));
              tau_m = 1/(am+bm);
              m_inf = am*tau_m;

              mkm[seg] = (mkm[seg] + dt*m_inf/tau_m)/(1+dt/tau_m);

              ikm[seg] = gkm*mkm[seg]*(v[seg]+91.0);

//             return ikm;


}


// Kc channel (Ca-dependent k channel)

void kc() { // From Migliore et al. 1995. J Neurophysiology
              // Based on data by Moczydlowski & Latorre, J Gen Physiol. 1983, 82:511-542 
              double ao,bo,tau_o,o_inf;

              double k1 = 0.48e-3;
              double k2 = 0.13e-6;
              double F1 = 96.4853;

              if(t<dt) {
                        v[seg] = -65;
                        ao = cai[seg]*0.28/(cai[seg]+k1*exp(-2*0.84*v[seg]*F1/(R*T)));
                        bo = 0.48/(1+cai[seg]/(k2*exp(-2*1.0*v[seg]*F1/(R*T))));
                        tau_o = 1/(ao+bo);
                        o_inf = ao*tau_o;
                        okc[seg] = o_inf;
                        ikc[seg] = 0.0;
              }


              ao = cai[seg]*0.28/(cai[seg]+k1*exp(-2*0.84*v[seg]*F1/(R*T)));
              bo = 0.48/(1+cai[seg]/(k2*exp(-2*1.0*v[seg]*F1/(R*T))));
              tau_o = 1/(ao+bo);
              o_inf = ao*tau_o;

              okc[seg] = (okc[seg] + dt*o_inf/tau_o)/(1+dt/tau_o);

//             double gkc = 0.01;
               ikc[seg] = gkc*okc[seg]*(v[seg]+91);

//             return ikc;

}


// Kahp channel (Ca-dependent k channel)

void kahp_new() { // From Lyle J. Borg-Graham, 1999  formulation. parameters are from Gold et al., 2006.
        
              double aw,bw,tau_w,w_inf,tau0;
 
              if(t<dt) {
                        cai[seg]  = 5e-5;  
                        aw = 1e31;
                        bw = 0.2;
                        tau0 = 5.0;
                        tau_w = 1/(aw*(pow(cai[seg],2))+bw)+tau0;
                        w_inf = aw*pow(cai[seg],2)/(aw*(pow(cai[seg],2))+bw);
                        wkahp[seg] = w_inf;
                        ikahp[seg] = 0.0;
              }
         
         
              aw = 1e31;
              bw = 0.2;
              tau_w = 1/(aw*pow(cai[seg],2)+bw)+tau0;
              w_inf = aw*pow(cai[seg],2)/(aw*pow(cai[seg],2)+bw);
     
              wkahp[seg] = (wkahp[seg] + dt*w_inf/tau_w)/(1+dt/tau_w);
 
              ikahp[seg] = gkahp*pow(wkahp[seg],8)*(v[seg]+91);
}


// leak current or passive current

void pas() {

//       double gpas = 1/Rm;
       ipas[seg] = gpas*(v[seg]-vrest);
//       return ipas;

}


