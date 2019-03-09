local lust = require "lust/lust"
local Enum = require "enum"

local describe, it, expect = lust.describe, lust.it, lust.expect

describe("Enums", function()
  it("can define a new enum", function()
    local letters = Enum {"a", "b", "c"}
  end)

  it("can access an enum directly by index", function()
    local stars = Enum {"sirius", "betelgeuse", "procyon", "antares"}

    expect(stars.sirius).to.be("sirius")
    expect(stars.betelgeuse).to.be("betelgeuse")
    expect(stars.procyon).to.be("procyon")
    expect(stars.antares).to.be("antares")

  end)

  it("will error on duplicate variant definitions", function()
    expect(function()
      local letters = Enum {"a", "b", "c", "d", "c"}
    end).to.fail()
  end)

  it("trying to access a variant that does not exist should fail", function()

    local brothers = Enum {"tsusi", "yowie", "dudi", "dodoy"}

    expect(function()
      print(brothers.wallachia)
    end).to.fail()
  end)

  it("trying to set a value on an enum should fail", function()
    local directions = Enum {"left", "right", "up", "down"}

    expect(function()
      directions.middle = true
    end).to.fail()
  end)

  it("can use non-string variants", function()
    local fibs = Enum {1, 2, 3, 5, 8, 13}

    expect(fibs[1]).to.be(1)
    expect(fibs[2]).to.be(2)
    expect(fibs[3]).to.be(3)
    expect(fibs[5]).to.be(5)
    expect(fibs[8]).to.be(8)
    expect(fibs[13]).to.be(13)

    local table_a, table_b, table_c = {}, {}, {}

    local all_tables = Enum {table_a, table_b, table_c}

    expect(all_tables[table_a]).to.be(table_a)
    expect(all_tables[table_b]).to.be(table_b)
    expect(all_tables[table_c]).to.be(table_c)
  end)

end)