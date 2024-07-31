# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set(VCPKG_TARGET_ARCHITECTURE arm64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CMAKE_SYSTEM_NAME Linux)
set(VCPKG_BUILD_TYPE release)

if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
  execute_process(COMMAND "uname" "-m"
                  OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

# Hide symbols in the AWS SDK. Fixes symbol collisions with
# other libraries (https://github.com/apache/arrow/issues/42154).
if("${PORT}" MATCHES "^aws-")
    set(VCPKG_CMAKE_CONFIGURE_OPTIONS "-DCMAKE_CXX_VISIBILITY_PRESET=hidden;-DCMAKE_C_VISIBILITY_PRESET=hidden")
endif()
