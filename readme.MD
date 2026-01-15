![alt text](<bastion server - employee.jpg>)


$ for dir in 30-bastion-server 20-sg 10-vpc; do
  cd $dir && terraform destroy -auto-approve && cd ..
done