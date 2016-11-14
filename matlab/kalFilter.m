function [ v ] = kalFilter(points,Qval,Rval)
A=[1 0 0; 0 1 0; 0 0 1];
Xk=points(1,:)';
Pk=[0 0 0;0 0 0;0 0 0];
H=[1 0 0; 0 1 0;0 0 1];
Q=[Qval 0 0;0 Qval 0;0 0 Qval];
R=[Rval 0 0; 0 Rval 0; 0 0 Rval];
v=zeros(size(points,1),3);
for i=1:size(points,1)
    Pkm=Pk;
    Xkm=Xk;
    Xkhat=A*Xkm;
    Pk=A*Pkm*A'+Q;
    Kk=Pk*H'*inv(H*Pk*H'+R);
    Xk=Xkhat+Kk*(points(i,:)'-H*Xkhat);
    Pk=(eye(3)-Kk*H)*Pk;
    v(i,:)=Xk;
end

%figure()
%plot(1:11,[0 ;repmat([10],10,1)])
%hold on
%plot(1:11,[0 ;v])

end

