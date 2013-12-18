name              "nginx_upload_module"
maintainer        "Jeff Rafter"
maintainer_email  "jeffrafter@gmail.com"
license           "Apache 2.0"
description       "Installs the nginx upload module from source"
version           "0.1.0"

recipe "upload", "Installs the nginx upload module from source"

%w{ ubuntu debian centos redhat amazon scientific oracle fedora }.each do |os|
  supports os
end

%w{ nginx }.each do |cb|
  depends cb
end
