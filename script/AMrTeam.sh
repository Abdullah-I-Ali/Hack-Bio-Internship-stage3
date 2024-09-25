  #!bin/bash  
  378  mkdir Karim_Abdullah
  379  mkdir biocomputing && cd biocomputing
  380  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
  381  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
  382  clear
  383  cd Home
  384  cd ../Home
  385  conda deactivate
  386  mkdir Karim_Abdullah
  387  mkdir biocomputing && cd biocomputing
  388  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
  389  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk 
  390  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
  391  mv wildtype.fna ../Karim_Abdullah/
  392  rm wildtype.gbk.1 
  393  grep "tatatata" ../Karim_Abdullah/wildtype.fna 
  394  grep "tatatata" ../Karim_Abdullah/ > mutant_sequences.txt
  395  grep "tatatata" ../Karim_Abdullah/wildtype.fna > mutant_sequences.txt
  396  clear
  397  conda deactivate
  398  mkdir Karim_Abdullah
  399  mkdir biocomputing && cd biocomputing
  400  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
  401  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk 
  402  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
  403  mv wildtype.fna ../Karim_Abdullah/
  404  rm wildtype.gbk.1 
  405  grep "tatatata" ../Karim_Abdullah/wildtype.fna 
  406  grep "tatatata" ../Karim_Abdullah/wildtype.fna > mutant_sequences.txt
  407  wget "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?id=X01714.1&db=nuccore&report=fasta&retmode=text" -O X01714.fasta
  408  wget "https://www.ncbi.nlm.nih.gov/sviewer/view/seq.cgi?db=nucleotide&id=ACCESSION_NUMBER&rettype=fasta&retmode=text" -O rpoB_fasta.fasta
  410  esearch -db nucleotide -query "Mycobacterium tuberculosis UKR100 rpoB" | efetch -format fasta > rpoB_fasta.fasta
  411  grep -v "^>" rpoB_fasta.fasta | grep -o "A" | wc -l
  412  grep -v "^>" rpoB_fasta.fasta | grep -o "C" | wc -l
  413  grep -v "^>" rpoB_fasta.fasta | grep -o "G" | wc -l
  414  grep -v "^>" rpoB_fasta.fasta | grep -o "T" | wc -l
  415  grep -v "^>" rpoB_fasta.fasta | wc -l
  416  GC=$(grep -v "^>" rpoB_fasta.fasta | grep -o "[GC]" | wc -l)
  417  TOTAL=$(grep -v "^>" rpoB_fasta.fasta | wc -c)
  418  echo "scale=2; $GC/$TOTAL*100" | bc
  419  touch Kareem_Abdullah.fasta
  420  cho "A count: X" >> YourName.fasta
  421  echo "G count: Y" >> YourName.fasta
  422  echo "T count: Z" >> YourName.fasta
  423  echo "C count: W" >> YourName.fasta
  424  echo "A count: 315" >>Kareem_Abdullah.fasta 
  425  echo "T count: 274" >>Kareem_Abdullah.fasta 
  426  echo "C count: 483" >>Kareem_Abdullah.fasta 
  427  echo "G count: 505" >>Kareem_Abdullah.fasta 
   
