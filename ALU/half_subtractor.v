module HalfSubtractor(A,B,D,Bout);
	input A,B;
    output D,Bout; 
    xor(D,A,B);
    and(Bout,~A,B);
endmodule