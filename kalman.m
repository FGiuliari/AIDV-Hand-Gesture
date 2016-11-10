A=[1 0 0; 0 1 0; 0 0 1];
Xk=[0 0 0]';
Pk=[0 0 0;0 0 0;0 0 0];
H=[1 0 0; 0 1 0;0 0 1];
Q=[0.1 0 0;0 0.1 0;0 0 0.1];
R=[1 0 0; 0 0 1; 0 0 1];
zk=[10 10 10]';
v=zeros(40,1);
for i=1:40
    Pkm=Pk;
    Xkm=Xk;
    Xkhat=A*Xkm;
    Pk=A*Pkm*A'+Q;
    Kk=Pk*H'*inv(H*Pk*H'+Q);
    Xk=Xkhat+Kk*(zk-H*Xkhat)
    Pk=(eye(3)-Kk*H)*Pk;
    v(i)=Xk(1);
end
figure()
plot(1:41,[0 ;repmat([10],40,1)])
hold on
plot(1:41,[0 ;v])