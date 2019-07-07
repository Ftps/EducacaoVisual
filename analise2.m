clear
file = "EV_2019.2_3";
fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

N = [2, 1.7; 3, 2.7; 4, 3.7; 5.5, 5.2; 7, 6.7; 0, 0.3; -1, -0.7; -2.5, -2.2];
N1 = 1; N2 = 2;
N_count = zeros(1, size_lin(N));

Time=1; EAS=2; QNE=3; a_z=4;
g=9.80665;
 eixo_y=["tempo","EAS (kts)","QNE (ft)","Acel. Vertical (m/s^2)","Vel. de Rotação (%)","Fuel Flow (lb/h)", "T. Gases Escape (K)","Vel. de Rotação (%)","Fuel Flow (lb/h)", "T. Gases Escape (K)"];

%plot temporal de todas as grandezas medidas
figure();
for i= EAS:a_z
    subplot(3,1,i-1)
    plot(m(:,Time), m(:,i));
    %axis([-inf inf 7.5 9.5]);
    xlabel('t (s)');
    ylabel(eixo_y(i));
end
%suptitle('Representacao temporal da EAS, QNE e aceleracao vertical');

figure();
for i=5:7
    subplot(1,3,i-4)
    plot(m(:,Time), m(:,i));
    %axis([-inf inf 7.5 9.5]);
    xlabel('t (s)');
    ylabel(eixo_y(i));
end
%suptitle('Representacao temporal da velocidade de rotacao, consumo e temperatura do motor direito');

figure();
for i=8:size_col(m)
    subplot(1,3,i-7)
    plot(m(:,Time), m(:,i));
    %axis([-inf inf 7.5 9.5]);
    xlabel('t (s)');
    ylabel(eixo_y(i));
end

G_acel=m(:,a_z)/g;
G_picos=[m(1, Time), G_acel(1)];
sinal=0;
for i=2:size_lin(G_acel)
    ddt=(G_acel(i)-G_acel(i-1))/(m(i,Time)-m(i-1,Time));

    if (sinal ~= sign(ddt) && sign(ddt)~= 0)
    G_picos=[G_picos; m(i, Time), G_acel(i)];
    sinal=sign(ddt);
    end
end

out_file = "picos_acel.txt";
fp = fopen(out_file,'w');
fprintf(fp,'%6s %12s\r\n','time','acel');
for i = 1:size_lin(G_picos)
    fprintf(fp,'%6.2f %12.8f\r\n',G_picos(i,1), G_picos(i,2));
end
fclose(fp);

for i=1:size_lin(N)
    sinal = 0;
    for j=1:size_lin(G_acel)
        if ~sinal && G_acel(j) >= N(i, N1)
            N_count(i) = N_count(i) + 1;
            sinal = 1;
        elseif sinal && G_acel(j) < N(i, N2)
            sinal = 0;
        end
    end
end


% funcao para ler os valores dos ficheiros
function mat = data_read(fp)
    cols = 1;
    line = fgets(fp);
    mat = 0;

    for i = 1:size_col(line)
        if line(i) == ';'
            cols = cols + 1;
        end
    end

    while ~feof(fp)
        line = fgets(fp);
        aux = sscanf(line, "%f;", [1, cols]);
        if mat == 0
            mat = aux;
        else
            mat = [mat; aux];
        end
    end

end

%funcoes auxiliares para tamanho da matriz
function n = size_col(v)
    [~, n] = size(v);
end

function n = size_lin(v)
    [n, ~] = size(v);
end
