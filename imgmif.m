    src = imread('imagen.jpg'); % Imagen
    gray = rgb2gray(src);
    [m,n] = size(gray);

    N = m*n;
    word_len = 32;
    data = reshape(gray, 1, N);

    fid=fopen('gray_image.mif', 'w');
    fprintf(fid, 'DEPTH=%d;\n', N);
    %fprintf(fid, 'WIDTH=%d;\n', word_len);

    %fprintf(fid, 'ADDRESS_RADIX = UNS;\n');
    %fprintf(fid, 'DATA_RADIX = HEX;\n');
    %fprintf(fid, 'CONTENT\t');
    %fprintf(fid, 'BEGIN\n');
    for i = 0 : N-1
    fprintf(fid, '\t%d\t:\t%x;\n',i+53, data(i+1));
    end
    %fprintf(fid, 'END;\n');
    fclose(fid);
