file = "EV_2019.3_3";

fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

Time = 1;
A1 = 2;
A2 = 3;
A3 = 4;
A4 = 5;


time = m(:,Time);
a1 = m(:,A1);
a2 = m(:,A2);
a3 = m(:,A3);
a4 = m(:,A4);

% representar graficamente a variação temporal das grandezas medidas
figure();
subplot(2,2,1);
plot(time, a1);
subplot(2,2,2);
plot(time, a2);
subplot(2,2,3);
plot(time, a3);
subplot(2,2,4);
plot(time, a4);


T = 0.004;
Fs = 1/T;
L = size_m(m);
NFFT = 2^(nextpow2(L));
ff = Fs/2*linspace(0,1,NFFT/2+1);

figure();

subplot(2,2,1);
dsms1 = fft(a1,NFFT)/L;
ssms1 = 2*abs(dsms1(1:(NFFT/2+1)));
plot(ff, ssms1);

%picos em 1,007/5,266 2,991/3,04 10,01/2,8 19,99/0,9311

subplot(2,2,2);
dsms2 = fft(a2,NFFT)/L;
ssms2 = 2*abs(dsms2(1:(NFFT/2+1)));
plot(ff, ssms2);

%pico em 3,998/3,725

subplot(2,2,3);
dsms3 = fft(a3,NFFT)/L;
ssms3 = 2*abs(dsms3(1:(NFFT/2+1)));
plot(ff, ssms3);

%pico em 2,014/5,437 3,998/3,717

subplot(2,2,4);
dsms4 = fft(a4,NFFT)/L;
ssms4 = 2*abs(dsms4(1:(NFFT/2+1)));
plot(ff, ssms4);

%pico em 2,014/5,445

% função para ler os valores dos ficheiros
function mat = data_read(fp)
    cols = 1;
    line = fgets(fp);
    mat = 0;
    
    for i = 1:size_vec(line)
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

%função auxiliar para tamanho do vetor
function n = size_vec(v)
    [~, n] = size(v);
end

%função auxiliar para saber o tamanho vertical do ficheiro
function n = size_m(v)
    [n, ~] = size(v);
end





