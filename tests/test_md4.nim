import
  std/unittest, ned2kpkg/md4



const
  Tests = [
    ["", "31d6cfe0d16ae931b73c59d7e0c089c0"],
    ["a", "bde52cb31de33e46245e05fbdbd6fb24"],
    ["abc", "a448017aaf21d8525fc10ae87aa6729d"],
    ["message digest", "d9130a8164549fe818874806e1c7014b"],
    ["abcdefghijklmnopqrstuvwxyz", "d79e1c308aa5bbcdeea8ed63df412da9"],
    ["ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "043f8582f241db351ce627e153e7f0e4"],
    ["12345678901234567890123456789012345678901234567890123456789012345678901234567890", "e33b4ddc9c38f2199c3e7b164fcc0536"]
  ]

suite "MD4 - single call":
  for d in Tests:
    test d[0]:
      check getMD4(d[0]) == d[1]

suite "MD4 - multiple updates":
  for d in Tests:
    test d[0]:
      var
        checksum = md4Init()
      for c in d[0]:
        checksum.md4Update([c.byte])
      check $checksum.md4Finalize() == d[1]
