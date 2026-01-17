![expense-terraform-dev/expense-tf-dev.svg](expense-tf-dev.svg)


for dir in 10-vpc 20-sg 30-bastion-server 40-apps; do 
cd $dir && terraform apply -auto-approve && cd ..done

$ for dir in 40-apps 30-bastion-server 20-sg 10-vpc; do
  cd $dir && terraform destroy -auto-approve && cd ..
done