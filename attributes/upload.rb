#
# Cookbook Name:: nginx_upload_module
# Attributes:: upload
#
# Author:: Jeff Rafter (<jeffrafter@gmail.com>)
#
# Copyright 2013
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['nginx']['upload']['url']      = "http://www.grid.net.ru/nginx/download/nginx_upload_module-2.2.0.tar.gz"
default['nginx']['upload']['checksum'] = "2681a6167551830a23336fa41bc539a1"
