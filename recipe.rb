[
  "build-essential",
].each do |package_name|
  package "#{package_name}" do
    action :install
    user "root"
  end
end
