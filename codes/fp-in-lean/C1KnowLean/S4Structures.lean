--
-- Float
--
#check 1.2
#check -454.2123215
#check 0.0

#check 0 -- 0 : Nat
#check (0 : Float) -- 0 : Float

structure Point where
  x : Float
  y : Float

def origin : Point := { x := 0.0, y := 0.0 }
#eval origin -- { x := 0.000000, y := 0.000000 }
#eval origin.x -- 0.000000
#eval origin.y -- 0.000000

def addPoints(p1: Point)(p2: Point): Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

#eval addPoints { x := 1.5, y := 32 } { x := -8, y := 0.2 } -- { x := -6.500000, y := 32.200000 }

def distance(p1: Point)(p2: Point): Float :=
  let dx := p1.x - p2.x
  let dy := p1.y - p2.y
  Float.sqrt (dx * dx + dy * dy)
#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 } -- 5.000000

structure Point3D where
  x : Float
  y : Float
  z : Float
def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }
-- ERROR: invalid {...} notation, expected type is not known
-- #check { x := 0.0, y := 0.0 }
#check ({ x := 0.0, y := 0.0 } : Point)
#check { x := 0.0, y := 0.0 : Point}

--------------------------------------------------------------------------------
-- update structures
--------------------------------------------------------------------------------

def zeroX(p: Point): Point := { p with x := 0.0 }
def fourAndThree: Point := { x := 4.3, y := 3.4 }
#eval fourAndThree -- { x := 4.300000, y := 3.400000 }
#eval zeroX fourAndThree -- { x := 0.000000, y := 3.400000 }
#eval fourAndThree -- { x := 4.300000, y := 3.400000 }

--------------------------------------------------------------------------------
-- behind the scene
--------------------------------------------------------------------------------
#check Point.mk 1.5 2.8 -- { x := 1.5, y := 2.8 } : Point
#check (Point.mk) -- Point.mk : Float → Float → Point

-- use `point` instead of `mk`
structure PointV2 where
  point ::
  x : Float
  y : Float
#check PointV2.point 1.5 2.8 -- { x := 1.5, y := 2.8 } : PointV2
#check (PointV2.x) -- PointV2.x : PointV2 → Float
def originV2 : PointV2 := { x := 0.0, y := 0.0 }
#eval originV2.x -- 0.000000
#eval PointV2.x originV2 -- 0.000000

#eval "one string".append " and another" -- "one string and another"

def Point.modifyBoth(f: Float -> Float)(p: Point): Point :=
  { x := f p.x, y := f p.y }
#eval fourAndThree.modifyBoth Float.floor -- { x := 4.000000, y := 3.000000 }


structure RectangularPrism where
  height : Float
  width : Float
  depth : Float

def volume(prism: RectangularPrism): Float :=
  prism.height * prism.width * prism.depth

structure Segment where
  startP : Point
  endP : Point

def length(seg: Segment): Float :=
  distance seg.startP seg.endP

structure Hamster where
  name : String
  fluffy : Bool
structure Book where
  makeBook ::
  title : String
  author : String
  price : Float

#check (Hamster) -- Hamster : Type
#check (Book) -- Book : Type
