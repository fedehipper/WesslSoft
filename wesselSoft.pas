Program WesselSoft;

Uses
	crt, math;

Type
   complejo = array[1..20] of real;

function mcd(a,b:integer):integer;
	var
		r:longint;
	begin
		r:=1;
        while r<>0 do
			begin
                r := a mod b;
                if r=0 then
					mcd:=b
                else
					begin
						a:=b;
						b:=r;
					end;
			end;
	end;

function coprimos(k,n:integer):boolean;
	begin
		if (mcd(k,n) = 1) then
			coprimos := TRUE
		else
			coprimos := FALSE;
	end;

procedure leerComplejo(var x,y:real; var forma:char);
	begin
		write('En que forma desea ingresar el numero complejo? Binomica (b) / Polar (p): ');
		readln(forma);
                while (forma<>'b') and (forma<>'p') do
                begin
                     writeln('Ingrese correctamente b (binomica) o p (polar)');
                     readln(forma);
                end;



		case forma of
			'b':	begin
					write('Parte Real [Re(z)]: ');
					readln(x);
					write('Parte Imaginaria [Im(z)]: ');
					readln(y);
				end;
			'p':	begin
					write('Modulo (Ro): ');
					readln(x);
					write('Argumento (Fi, en Radianes): ');
					readln(y);
				end;
		end;
	end;

procedure suma(a,b,c,d:real; var x,y:real);
    begin
		x:=a+c;
        y:=b+d;
    end;

procedure resta(a,b,c,d:real; var x,y:real);
    begin
        x:=a-c;
        y:=b-d;
    end;

function modulo(a,b:real):real;
	begin
		modulo := sqrt(sqr(a) + sqr(b));
	end;

procedure prodBinom(a,b,c,d:real; var x,y:real);
	begin
		x := (a*c) - (b*d);
		y := (a*d) + (b*c);
	end;

procedure conjugado(a,b:real; var x,y:real);
	begin
		x := a;
		y := -b;
	end;

procedure cocienteBinom(a,b,c,d:real; var x,y:real);
	var
		c2,d2,denom,numR,numI:real;
	begin
		conjugado(c,d,c2,d2);
		denom := sqr(modulo(a,b));
		prodBinom(a,b,c2,d2,numR,numI);
		x := (numR / denom);
		y := (numI / denom);
	end;

procedure calcArg(a,b:real ; var phi:real); {Phi est� en Radianes}
	begin
		case Sign(a) of
			-1: begin
					if b<>0 then {2do y 3er Cuadrante}
						phi := arctan(b/a) + pi
					else
						phi := pi; {Eje Real}
				end;
			0: begin {Imaginario Puro}
					case Sign(b) of
						-1: phi := (1.5 * pi);
						0: phi := 0; {Punto en el Origen}
						1: phi := (0.5 * pi);
					end;
				end;
			1: begin
					if b>=0 then {1er Cuadrante}
						phi := arctan(b/a)
					else {4to Cuadrante}
						phi := arctan(b/a) + (2 * pi);
				end;
		end;
	end;

procedure calcArgSinPrimerGiroPos(a,b:real ; var phi:real); {Phi est� en Radianes}
	begin
		case Sign(a) of
			-1:	if b<>0 then 					{2do y 3er Cuadrante}
					phi := arctan(b/a)
				else
					phi := pi; 					{Eje Real}

			0:	case Sign(b) of					{Imaginario Puro}
				-1: phi := (1.5 * pi);
				0: phi := 0; 					{Punto en el Origen}
				1: phi := (0.5 * pi);
				end;

			1: phi := arctan(b/a);
		end;
	end;

procedure binAPolar(a,b:real; var rho,phi:real);
	begin
		rho := modulo(a,b);
		calcArg(a,b,phi);
	end;

procedure binAPolarSinPrimerGiroPos(a,b:real; var rho,phi:real);
	begin
		rho := modulo(a,b);
		calcArgSinPrimerGiroPos(a,b,phi);
	end;

procedure prodPolar(rho1,phi1,rho2,phi2:real; var rho,phi:real);
	begin
		rho := (rho1 * rho2);
		phi := (phi1 + phi2);
	end;

procedure cocientePolar(rho1,phi1,rho2,phi2:real; var rho,phi:real);
	begin
		rho := (rho1 / rho2);
		phi := (phi1 - phi2);
	end;

procedure potenciaPolar (var rho,phi:real; n:integer);
	begin
		rho := power(rho,n);
		phi := (n * phi);
	end;

procedure binAPolar2(a,b:real; var x,y:real);
var
d:real; j:real;
c:real;

begin
        if (a>0) and (b>0) then
        begin
                c:=b/a;
                y:=arcTan(c);
                x:=modulo(a,b);
        end else begin
        end;

        if (a<0) and (b<0) then
        begin
             c:=b/a;
             y:=arcTan(c);
             x:=modulo(a,b);
        end else begin
        end;

        if (a<0) and (b>0) then
        begin
             c:=b/a;
             y:=arcTan(c);
             x:=modulo(a,b);
        end else begin
        end;

        if (a>0) and (b<0) then
        begin
             c:=b/a;
             y:=arcTan(c);
             x:=modulo(a,b);
        end else begin
        end;

        if (a>0) and (b=0) then
        begin
             y:=0;
             x:=modulo(a,b);
        end else begin
        end;

        if (a<0) and (b=0) then
        begin
             y:=pi;
             x:=modulo(a,b);
        end else begin
        end;

        if (a=0) and (b>0) then
        begin
             y:=0.5*pi;
             x:=modulo(a,b);
        end else begin
        end;

        if (a=0) and (b<0) then
        begin
             y:=1.5*pi;
             x:=modulo(a,b);
        end else begin
        end;

end;

// Pasaje de forma Polar a Bin�mica
procedure polarABin(rho,phi:real; var x,y:real);
	begin
		x := rho * Cos(phi);
                y := rho * Sin(phi);
	end;

procedure raizCuadradaBinom(a,b:real; var x1,x2,y1,y2:real);
	var
		x,y:real;
	begin
		x := sqrt((modulo(a,b) + a) / 2);
		y := sqrt((modulo(a,b) - a) / 2);
		case sign(b) of
			-1: begin 							// signos distintos, por un lado (x,y) y por el otro (w,z)
					x1 := x;
					y1 := -y;
					x2 := -x;
					y2 := y;
			    end;					        // cuando b=0, si a>0 entonces da en los parametros que los
			 0: begin                           // puse como reales su valor , son x,w,  y con a<0 en y,z pero
					y1 := 0;                    // a estos como son complejos por j
					y2 := 0;
					if a>0 then
					begin
							x1 := sqrt(a);
							x2 := -sqrt(a);
					end else begin          // si a<0 es lo mismo pero multiplicado por j

									x1 := sqrt(-a);
									x2 := -sqrt(-a);
					end;
			    end;
			 1: begin
					x1 := x;
					y1 := y;
					x2 := -x;
					y2 := -y;
			    end;

		end;
	end;

procedure raizNesimaPolar(rho,phi:real; n:integer);
	var
		x1,x2,y1,y2,ro,fi:real;
		k:integer;
	begin
		while n = 0 do
			begin
				write('Por favor ingrese un valor de N valido (distinto de 0): ');
				readln(n);
			end;
		case n of
			1:	begin
					polarABin(rho,phi,x1,y1);
					writeln('w = [', rho:2:2,' , ',phi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')');
				end;
			2:	begin
					polarABin(rho,phi,x1,y1);
					raizCuadradaBinom(x1,y1,x1,x2,y1,y2);
					binAPolar(x1,y1,ro,fi);
					writeln('w0 = [', ro:2:2,' , ',fi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')');
					binAPolar(x2,y2,ro,fi);
					writeln('w1 = [', ro:2:2,' , ',fi:2:2,'] = (',x2:2:2,' , ',y2:2:2,')');
				end;
			else
				begin
					ro := power(rho,(1/n));
					for k:=0 to n-1 do
						begin
							fi := (phi + 2 * k * pi) / n;
							polarABin(ro,fi,x1,y1);
							writeln('w',k,' = [',ro:2:2,' , ',fi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')');
						end;
				end;
		end;
	end;

procedure sumaFasor(r1,r2,p1,p2,a1,a2:real; f1,f2:string; var r3,p3,a3:real; var f3:string);
var
x1,x2,y1,y2,w1,w2:real;
begin
     if f1=f2 then
     begin
          polarABin(r1,a1,x1,y1);
          polarABin(r2,a2,x2,y2);
          suma(x1,y1,x2,y2,w1,w2);
          binAPolar2(w1,w2,r3,a3);
          p3:=p1;
          f3:=f1;
     end else begin
         if f1='cos'then
         begin
              // entonces a f2 hay que sumarle 90
              polarABin(r1,a1,x1,y1);
              polarABin(r2,a2-(0.5*pi),x2,y2);
              suma(x1,y1,x2,y2,w1,w2);
              binAPolar2(w1,w2,r3,a3);
              p3:=p1;
              f3:=f1;
         end else begin
             if f1='sin'then
             begin
                  // le sumo 90 a f1
                  polarABin(r1,a1-(0.5*pi),x1,y1);
                  polarABin(r2,a2,x2,y2);
                  suma(x1,y1,x2,y2,w1,w2);
                  binAPolar2(w1,w2,r3,a3);
                  p3:=p1;
                  f3:=f2;
             end else begin
             end;
         end;
     end;
end;


procedure seleccionarOperacion(op:string);
var
	a,b,c,d,x,x1,x2,y,y1,y2,rho,phi,ro,fi:real;
	pReal,pComp,r1,r2,p1,p2,a1,a2,r3,p3,a3:real;
	k,longArrayPolos,longArrayCeros,n:integer;
	respuesta,forma,forma1,forma2:char;
	polos,ceros:complejo;
	f1,f2,f3:string;
	num:real;
	denom:real;
	sumArgPolos,sumArgCeros:real;
	i,j:byte;
	acumCero,acumPolo:real;
	argTot,moduloComplejo:real;
begin
	case op of
		'1':	begin
				writeln;
				writeln('ADICION');
				writeln;
				writeln('Ingrese a continuacion los numeros complejos a sumar.');
				writeln;
				writeln('Primer complejo:');
				leerComplejo(a,b,forma);
				if forma = 'p' then
                                begin
                                        ro:=a;
                                        fi:=b;
                                        polarABin(ro,fi,a,b);										{ADICI�N}
                                end else begin
                                end;

                                writeln('Segundo complejo:');
				leerComplejo(c,d,forma);
				if forma = 'p' then
                                begin
                                        ro:=c;
                                        fi:=d;
                                        polarABin(ro,fi,c,d);
                                end else begin
                                end;

                                suma(a,b,c,d,x,y);
				writeln('(',a:2:2,' , ',b:2:2,') + (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,')');
			end;

		'2':	begin
				writeln;
				writeln('SUSTRACCION');
				writeln;
				writeln('Ingrese a continuacion los numeros complejos a restar.');
				writeln;
				writeln('Primer complejo:');

                                leerComplejo(a,b,forma);
				if forma = 'p' then
                                begin
                                        ro:=a;
                                        fi:=b;
					polarABin(ro,fi,a,b);
                                end else begin
                                end;                                                                    {SUSTRACCI�N}

                                writeln('Segundo complejo:');
                                leerComplejo(c,d,forma);
				if forma = 'p' then
                                begin
                                        ro:=c;
                                        fi:=d;
					polarABin(ro,fi,c,d);
                                end else begin
                                end;

				resta(a,b,c,d,x,y);
				writeln('(',a:2:2,' , ',b:2:2,') - (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,')');
			end;

		'3':	begin
				writeln;
				writeln('PRODUCTO');
				writeln;
				writeln('Ingrese a continuacion los numeros complejos a multiplicar.');
				writeln;
				writeln('Primer complejo:');
				leerComplejo(a,b,forma1);  //
				writeln('Segundo complejo:');
				leerComplejo(c,d,forma2);
				if forma1 = forma2 then
                                begin
					case forma1 of
						'p':	begin
									prodPolar(a,b,c,d,ro,fi);
									polarABin(ro,fi,x,y);
									writeln('[',a:2:2,' , ',b:2:2,'] * [',c:2:2,' , ',d:2:2,'] = [',ro:2:2,' , ',fi:2:2,'] = (',x:2:2,' , ',y:2:2,')');
						        end;
						'b':	begin
									prodBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') * (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
					                end;
                                        end;
				end else begin
					case forma1 of
						'p':	begin
									polarABin(a,b,a,b);							{PRODUCTO}
									prodBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') * (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
							end;
						'b':	begin
									polarABin(c,d,c,d);
									prodBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') * (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
						        end;
					end;
				end;
			end;

		'4':	begin
				writeln;
				writeln('COCIENTE');
				writeln;
				writeln('Ingrese a continuacion los numeros complejos a dividir.');
				writeln;
				writeln('Primer complejo:');
				leerComplejo(a,b,forma1);
				writeln('Segundo complejo:');
				leerComplejo(c,d,forma2);
				while ((c=0) AND (d=0)) do
					begin
						writeln('No es posible calcular el cociente con el numero complejo seleccionado pues el denominador resultaria nulo. Por favor elija a continuacion otro numero complejo.');
						leerComplejo(c,d,forma2);
					end;
				if forma1 = forma2 then
                                begin
					case forma1 of
						'p':	begin
									cocientePolar(a,b,c,d,ro,fi);
									polarABin(ro,fi,x,y);
									writeln('[',a:2:2,' , ',b:2:2,'] / [',c:2:2,' , ',d:2:2,'] = [',ro:2:2,' , ',fi:2:2,'] = (',x:2:2,' , ',y:2:2,')');
						        end;
						'b':	begin
									cocienteBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') / (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
					                end;
                                        end;
				end else begin
					case forma1 of
						'p':	begin
									polarABin(a,b,a,b);							{COCIENTE}
									cocienteBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') / (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
						        end;
						'b':	begin
									polarABin(c,d,c,d);
									cocienteBinom(a,b,c,d,x,y);
									binAPolar(x,y,ro,fi);
									writeln('(',a:2:2,' , ',b:2:2,') / (',c:2:2,' , ',d:2:2,') = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
					                end;
					end;
                                end;
			end;

		'5':	begin
				writeln;
				writeln('POTENCIA');
				writeln;
				writeln('Ingrese a continuacion el complejo a utilizar como base, seguido de la potencia (n) a la cual desea elevarlo.');
				leerComplejo(a,b,forma);
				write('Potencia (n): ');
				readln(n);
				if forma = 'p' then
					begin
						ro := a;												{POTENCIA}
						fi := b;
						potenciaPolar(ro,fi,n);
						polarABin(ro,fi,x,y);
						writeln('[',a:2:2,' , ',b:2:2,'] ^ ',n,' = [',ro:2:2,' , ',fi:2:2,'] = (',x:2:2,' , ',y:2:2,')');
					end
				else
					begin
						case n of
							0:	begin
									x := 1;
									y := 0;
								end;
							1:	begin
									x := a;
									y := b;
								end;
							else	begin
										prodBinom(a,b,a,b,x,y);
										for k:=2 to n-1 do
											prodBinom(x,y,a,b,x,y);
									end;
						end;
						binAPolar(x,y,ro,fi);
						writeln('(',a:2:2,' , ',b:2:2,') ^ ',n,' = (',x:2:2,' , ',y:2:2,') = [',ro:2:2,' , ',fi:2:2,']');
					end;
				end;

		'6':	begin
				writeln;
				writeln('RAIZ CUADRADA');
				writeln;
				writeln('Ingrese a continuacion el complejo a utilizar como base de la raiz cuadrada');
				leerComplejo(a,b,forma);
				if forma = 'p' then												{RAIZ CUADRADA}
				begin
						polarABin(a,b,x1,y1);

						raizCuadradaBinom(x1,y1,x1,x2,y1,y2);
						binAPolar(x1,y1,ro,fi);
						writeln('w0 = [', ro:2:2,' , ',fi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')');
						binAPolar(x2,y2,ro,fi);
						writeln('w1 = [', ro:2:2,' , ',fi:2:2,'] = (',x2:2:2,' , ',y2:2:2,')');
				end else begin
						raizCuadradaBinom(a,b,x1,x2,y1,y2);
						binAPolar(x1,y1,ro,fi);
						writeln('w0 = [', ro:2:2,' , ',fi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')');
						binAPolar(x2,y2,ro,fi);
						writeln('w1 = [', ro:2:2,' , ',fi:2:2,'] = (',x2:2:2,' , ',y2:2:2,')');
				end;
			end;

		'7':	begin
				writeln;
				writeln('RAIZ N-ESIMA');
				writeln;
				writeln('Ingrese a continuacion el complejo a utilizar como base de la raiz, seguido del orden (n) de la misma.');
				leerComplejo(a,b,forma);
				write('Orden de radicacion (n): ');
				readln(n);
				if forma = 'b' then												{RAIZ N-�SIMA}
					begin
						binAPolar(a,b,ro,fi);
						raizNesimaPolar(ro,fi,n);
					end
				else
					raizNesimaPolar(a,b,n);
			end;

		'8':	begin
				writeln;
				writeln('RAICES PRIMITIVAS DE LA UNIDAD');
				writeln;
				a:=1;
				b:=0;
				write('Ingrese el orden N (N>2) de la raices primitivas a encontrar: ');
				readln(n);
				writeln;
				while NOT ((n<>2) AND (n>1)) do
					begin
						writeln('Ingrese a continuacion el orden (n>2) de la raices primitivas a encontrar.');
						write('Recuerde, orden (n>2): ');
						readln(n);
					end;
				binAPolarSinPrimerGiroPos(a,b,rho,phi);
				ro := power(rho,(1/n));
				for k:=0 to n-1 do
					begin
						fi := (phi + 2 * k * pi) / n;							{RAICES PRIMITIVAS}
						polarABin(ro,fi,x1,y1);
						write('w',k,' = [',ro:2:2,' , ',fi:2:2,'] = (',x1:2:2,' , ',y1:2:2,')      ');
						case k of
							0:		begin
										writeln('w0 NUNCA es una primitiva.');
										writeln;
									end;
							1:		begin
										writeln('w1 SIEMPRE es una primitiva.');
										writeln;
									end;
							else	if coprimos(k,n) then
										begin
											writeln('w',k,' SI es una primitiva.');
											writeln;
										end
									else
										begin
											writeln('w',k,' NO es una primitiva.');
											writeln;
										end;
						end;
					end;
			end;

		'9':	begin
					writeln;
					writeln('SUMA DE FASORES');
					writeln('---------------');
					writeln;
					writeln('Primera Funcion');
					writeln('...............');
					writeln;
					write('Amplitud: ');
					readln(r1);
					write('Funcion Senoidal (sin) o Cosenoidal (cos)?: ');
					readln(f1);
					while (f1 <> 'sin') and (f1 <> 'cos') do
						begin
							write('Por favor, ingrese textualmente ''sin'' o ''cos'' (sin apostrofo): ');
							readln(f1);
						end;
					write('Frecuencia: ');
					readln(p1);
					write('Fase Inicial (solo multiplo racional de Pi en forma decimal, sin Pi): ');
					readln(a1);
					a1 := a1 * pi;
					writeln;
					writeln('Segunda Funcion');
					writeln('...............');
					writeln;
					write('Amplitud: ');
					readln(r2);
					write('Funcion Senoidal (sin) o Cosenoidal (cos)?: ');
					readln(f2);
					while (f2 <> 'sin') and (f2 <> 'cos') do
						begin
							write('Por favor, ingrese textualmente ''sin'' o ''cos'' (sin apostrofo): ');
							readln(f2);
						end;
					write('Frecuencia: ');
					readln(p2);
					write('Fase Inicial (solo multiplo racional de Pi en forma decimal, sin Pi): ');
					readln(a2);
					a2 := a2 * pi;
					writeln;
					write('F1 + F2 = ');
					sumaFasor(r1,r2,p1,p2,a1,a2,f1,f2,r3,p3,a3,f3);
					case Sign(a3) of
						-1:	writeln(r3:2:2, ' . ', f3, ' (',p3:2:2, 't - ', abs(a3):2:3, ')');
						0:	writeln(r3:2:2, ' . ', f3, ' (',p3:2:2, 't)');
						1:	writeln(r3:2:2, ' . ', f3, ' (',p3:2:2, 't + ', a3:2:3, ')');
					end;
				end;

		'10':	begin
				sumArgPolos:=0;
				sumArgCeros:=0;
				longArrayPolos:=0;
				longArrayCeros:=0;
				respuesta:='0';
				writeln('TRANSFERENCIA');
				writeln('Ingrese el numero complejo (valor de la funcion)');
				readln(pReal,pComp);
				writeln('Ingrese los polos en forma binomica (a,b):');
				while respuesta<>'n' do
					begin
						writeln('Ingrese el numero complejo');
						readln(a,b);
                                                x1:=pReal-a;
                                                x2:=pComp-b;
                                                binAPolar(x1,x2,rho,phi);
                                                sumArgPolos:=sumArgPolos+phi;
                                                longArrayPolos:=longArrayPolos+1;
						polos[longArrayPolos]:=modulo(x1,x2);
                                                writeln('desea ingresar otro polo, s/n');
						readln(respuesta);
					end;
				respuesta:='s';
				writeln('Ingrese los ceros en forma binomica (a,b):');
				while respuesta<>'n' do
					begin
						writeln('Ingrese el numero complejo');
						readln(a,b);
                                                x1:=pReal-a;
                                                x2:=pComp-b;
                                                binAPolar(x1,x2,rho,phi);
                                                sumArgCeros:=sumArgCeros+phi;
                                                longArrayCeros:=longArrayCeros+1;
						ceros[longArrayCeros]:=modulo(x1,x2);
						writeln('desea ingresar otro cero? s/n:');
						readln(respuesta);
					end;
				writeln('Ingrese la constante de proporcionalidad');
				readln(k);

                                i:=1;
                                acumCero:=1;
                                while i<=longArrayCeros  do
                                begin
                                     acumCero:=ceros[i]*acumCero;
                                     i:=i+1;
                                end;

                                num:=k*acumCero;

                                j:=1;
                                acumPolo:=1;
                                while j<=longArrayPolos  do
                                begin
                                     acumPolo:=polos[j]*acumPolo;
                                     j:=j+1;
                                end;

                                denom:=acumPolo;

                                argTot:=sumArgCeros-sumArgPolos;

                                if denom<>0 then
                                begin
                                   moduloComplejo:=num/denom;
                                   polarABin(moduloComplejo,argTot,x,y);
                                   writeln('forma binomica  (',x:2:2,',',y:2:2,')');
                                   writeln('forma polar  [',moduloComplejo:2:2,';',argTot:2:2,']');
                                end else begin
                                   writeln('no se pudo realizar operacion!!!');
                                end;
			end;

		else	writeln('Disculpe, operacion no reconocida. Por favor, seleccione una operacion');
                writeln ('valida (1-10) o F para finalizar');	{Mensaje de error (opci�n incorrecta)}
    end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{Programa Principal}
var
	op:string;
begin
	writeln('WESSEL SOFT - Software para Operaciones con Numeros Complejos');
	writeln('-------------------------------------------------------------');
	writeln;
	writeln('Operaciones:');
	writeln('------------');
	writeln('1) ADICION');
	writeln('2) SUSTRACCION');
	writeln('3) PRODUCTO');
	writeln('4) COCIENTE');
	writeln('5) N-esima POTENCIA');
	writeln('6) RAIZ CUADRADA');
	writeln('7) RAIZ N-esima');
	writeln('8) RAICES PRIMITIVAS DE LA UNIDAD');
	writeln('9) SUMA DE FUNCIONES SINUSOIDALES (FASORES)');
	writeln('10) FUNCION TRANSFERENCIA');
	writeln('-------------------------------------------------------------');
	writeln;
	write('Seleccione numero de operacion o F para finalizar: ');
	readln(op);
	while NOT ((op='f') OR (op='F')) do
		begin
			seleccionarOperacion(op);

			writeln;
			write('Desea realizar otra operacion? (s/n): ');

                        readln(op);
                        while (op<>'s') and (op<>'n') do
                        begin
                             writeln('seleccione en forma correcta: ');
                             writeln('si (s) para continuar o no (n) para finalizar: ');
                             readln(op);
                        end;

			if ((op = 's') OR (op = 'S')) then
				begin
					writeln;
					writeln('WESSEL SOFT - Software para Operaciones con Numeros Complejos');
					writeln('-------------------------------------------------------------');
					writeln;
					writeln('Operaciones:');
					writeln('------------');
					writeln('1) ADICION');
					writeln('2) SUSTRACCION');
					writeln('3) PRODUCTO');
					writeln('4) COCIENTE');
					writeln('5) N-esima POTENCIA');
					writeln('6) RAIZ CUADRADA');
					writeln('7) RAIZ N-esima');
					writeln('8) RAICES PRIMITIVAS DE LA UNIDAD');
					writeln('9) SUMA DE FUNCIONES SINUSOIDALES (FASORES)');
					writeln('10) FUNCION TRANSFERENCIA');
					writeln('-------------------------------------------------------------');
					writeln;
					write('Seleccione numero de operacion o F para finalizar: ');
					readln(op);
				end
			else
				op := 'f';
		end;
	writeln('Gracias por utilizar los servicios de WesselSoft. Hasta la proxima!');
END.
