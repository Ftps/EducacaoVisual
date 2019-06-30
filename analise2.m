clear
file = "EV_2019.2_3";
fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);

Time=1; EAS=2; QNE=3;

%plot temporal de todas as grandezas medidas
for i=2:size_col(m)
    plot(m(:,Time), m(:,i));
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


