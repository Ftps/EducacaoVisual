clear
file = "EV_2019.2_3";
fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

N = [2, 1.7; 3, 2.7; 4, 3.7; 5.5, 5.2; 7, 6.7; 0, 0.3; -1, -0.7; -2.5, -2.2];
N1 = 1; N2 = 2;
N_count = zeros(size_lin(N));

Time=1; EAS=2; QNE=3; a_z=4;
g=9.80665;

%plot temporal de todas as grandezas medidas
figure();
for i= EAS:a_z
    subplot(3,1,i-1)
    plot(m(:,Time), m(:,i));
end
suptitle('Representacao temporal da EAS, QNE e aceleracao vertical');

figure();
for i=5:size_col(m)
    subplot(2,3,i-a_z)
    plot(m(:,Time), m(:,i));
end
suptitle('Representacao temporal da velocidade de rotacao, consumo e temperatura dos motores direito e esquerdo');


G_acel=m(:,a_z)/g;
G_picos=G_acel(1);
for i=2:size_lin(G_acel)
    ddt=(G_acel(i)-G_acel(i-1))/(m(i,Time)-m(i-1,Time));
    sinal=sign(ddt);
    if sinal
    G_picos=[G_picos, G_acel(i)];
    end
end

out_file = "picos_acel.txt";
fp = fopen(out_file,'w');

fclose(fp);

sinal = 0;
for i=1:size_lin(N)
    for j=1:size_col(G_acel)
        

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


