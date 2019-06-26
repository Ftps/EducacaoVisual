file = "EV_2019.3_3";

fp = fopen(file,'r');
m = data_read(fp);
fclose(fp);







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




