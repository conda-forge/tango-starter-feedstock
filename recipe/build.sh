cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=true \
      -S . \
      -B build

cmake --build build
cmake --install build

# Separate debugging symbols on Linux
if [ -n "${OBJCOPY}" ]
then
  mkdir -p ${PREFIX}/lib/debug
  ${OBJCOPY} --only-keep-debug ${PREFIX}/bin/Starter ${PREFIX}/lib/debug/Starter.dbg
  chmod 664 ${PREFIX}/lib/debug/Starter.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/bin/Starter
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/debug/Starter.dbg ${PREFIX}/bin/Starter
fi
