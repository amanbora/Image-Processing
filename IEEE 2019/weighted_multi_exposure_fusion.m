clc;close all;clear all;Ix=imread('./images/test2.jpg');figure(1);imshow(Ix);I1 = double(Ix);I = double(Ix);r = double(Ix(:,:,1));g = double(Ix(:,:,2));b = double(Ix(:,:,3));%first functionIr = r.* (20/ 61);Ig = g.*(40/ 61);Ib = b ./ 61;Ir = double(Ir);Ig = double(Ig);Ib = double(Ib);amax = 1;amin = .1;fg = double(size(Ig));fr = double(size(Ir));fb = double(size(Ib));I(:,:,1) = Ir;I(:,:,2) = Ig;I(:,:,3) = Ib;%second function[m,n] = size(fr);imagseq = zeros(m,n,3,6);w1 = 0.3;w2 = 0.3;w3 = 0.4;for i = 1:1:6      %first function    am = amin + (amax-amin)*(i-1)/5;    am        fg = Ig + (Ig.*max(max(g))-Ig.^2)./sqrt(Ig.^2 + am^2);    fb = Ib + (Ib.*max(max(b))-Ib.^2)./sqrt(Ib.^2 + am^2);    fr = Ir + (Ir.*max(max(r))-Ir.^2)./sqrt(Ir.^2 + am^2);                    I1(:,:,1) = fr;    I1(:,:,2) = fg;    I1(:,:,3) = fb;        [m,n] = size(Ir);    imagseq = zeros(m,n,3,6);    imagSeq(:,:,:,i) = I1;           figure(i+1);    new_img = uint8(I1);    image(I1);end%second function    Iycbcr = rgb2ycbcr(I);    Icb = Iycbcr(:,:,2);    Icr = Iycbcr(:,:,3);        functCont = w1 * ( blendexposure(imagSeq(:,:,:,1),imagSeq(:,:,:,2),imagSeq(:,:,:,3),imagSeq(:,:,:,4),imagSeq(:,:,:,5),imagSeq(:,:,:,6), 'contrast',0.5));    funcSat = -w2 * ((Icb-0.5).^2 + (Icr-0.5).^2);    functExp = w3 * ( blendexposure(imagSeq(:,:,:,1),imagSeq(:,:,:,2),imagSeq(:,:,:,3),imagSeq(:,:,:,4),imagSeq(:,:,:,5),imagSeq(:,:,:,6),'wellexposedness',0.5));            fusedImg =  blendexposure(I,imagSeq(:,:,:,1),imagSeq(:,:,:,2),imagSeq(:,:,:,3),imagSeq(:,:,:,4),imagSeq(:,:,:,5),imagSeq(:,:,:,6),'wellexposedness',w3*0.5,'contrast',w1*0.5 );      image(fusedImg);         