function interval=calhmci(auc,z,n1,n2)
% Hanley and McNeil (1982)

% r = z * sqrt( (auc * (1 - auc)) / n);
% interval = [auc-r auc+r];

% q0=auc*(1-auc);
% q1=auc/(2-auc)-auc^2;
% q2 = 2*auc^2/(1+auc)-auc^2;
% se = sqrt((q0+(n1-1)*q1+(n2-1)*q2)/(n1*n2));
% interval=[auc-se*z auc+se*z];

q1 = auc/(2-auc);
q2 = 2*auc*auc/(1+auc);
se = sqrt( ( auc*(1-auc)+(n1-1)*(q1-auc^2)+(n2-1)*(q2-auc^2) ) / (n1*n2) );
interval = [auc-z*se auc+z*se];