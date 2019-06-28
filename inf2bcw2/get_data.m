%dset_dir = 'C:\Users\sakib\Documents\Inf2B\inf2bcw2';
dset_dir = '/afs/inf.ed.ac.uk/user/s17/s1759855/Downloads/2b';
[Xtrn, Ytrn, Xtst, Ytst] = load_my_data_set(dset_dir);
Xtrn = double(Xtrn)/255.0;
Xtst = double(Xtst)/255.0;
%disp_one(Xtrn, Ytrn);