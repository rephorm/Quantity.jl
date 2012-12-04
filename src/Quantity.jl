module QuantityMod

export
  Unit,
  unitless,
  length_unit, mass_unit, time_unit,
  Quantity

type Unit
   repr::Array{Number}  # Length, Mass, Time

   Unit{T<:Number}(r::Array{T,1}) = new(convert(Array{Number}, r))
end

const unitless = Unit([0,0,0])
const length_unit = Unit([1,0,0])
const mass_unit = Unit([0,1,0])
const time_unit = Unit([0,0,1])

import Base.*, Base./, Base.+, Base.-
*(x::Unit, y::Unit) = Unit(x.repr + y.repr)
/(x::Unit, y::Unit) = Unit(x.repr - y.repr)


type Quantity{T<:Number}
    val::T
    unit::Unit
end

function +(x::Quantity, y::Quantity)
    if x.unit != y.unit
    end
    Quantity(x.val + y.val, x.unit)
end

function -(x::Quantity, y::Quantity)
    if x.unit != y.unit
    end
    Quantity(x.val - y.val, x.unit)
end

+(x::Quantity, y::Quantity) = x.unit == y.unit ? Quantity(x.val + y.val, x.unit) : error("Can't add quantities with different units")
-(x::Quantity, y::Quantity) = x.unit == y.unit ? Quantity(x.val - y.val, x.unit) : error("Can't subtract quantities with different units")
*(x::Quantity, y::Quantity) = Quantity(x.val * y.val, x.unit * y.unit)
/(x::Quantity, y::Quantity) = Quantity(x.val / y.val, x.unit / y.unit)

import Base.convert

convert{T<:Number}(::Type{T}, x::Quantity) = x.unit == unitless ? convert(T, x.val) : error("Dropping units not allowed")


end # module Quantity
