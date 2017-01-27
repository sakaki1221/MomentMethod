@Title undisplaced_2

@Columns AsymmetricAtom
	AtomicNumber	int	0
	Connections	string	{{}}
	Fractional	double	{{0.0 0.0 0.0}}
	Name	string	{{}}
	Site	int	1
	WyckoffPosition	int	-1
@end
@data
79 {} {0.75 0.75 0.5} Au 1 -1
79 {} {0.75 0.75 0} Au 1 -1
79 {} {0.75 0 0.25} Au 1 -1
79 {} {0.75 0.25 0.5} Au 1 -1
79 {} {0 0.75 0.25} Au 1 -1
79 {} {0 0 0.5} Au 1 -1
79 {} {0.25 0.75 0.5} Au 1 -1
79 {} {0.75 0 0.75} Au 1 -1
79 {} {0.75 0.25 0} Au 1 -1
79 {} {0.75 0.5 0.25} Au 1 -1
79 {} {0 0.75 0.75} Au 1 -1
79 {} {0 0 0} Au 1 -1
79 {} {0 0.25 0.25} Au 1 -1
79 {} {0 0.5 0.5} Au 1 -1
79 {} {0.25 0.75 0} Au 1 -1
79 {} {0.25 0 0.25} Au 1 -1
79 {} {0.25 0.25 0.5} Au 1 -1
79 {} {0.5 0.75 0.25} Au 1 -1
79 {} {0.5 0 0.5} Au 1 -1
79 {} {0.75 0.5 0.75} Au 1 -1
79 {} {0 0.25 0.75} Au 1 -1
79 {} {0 0.5 0} Au 1 -1
79 {} {0.25 0 0.75} Au 1 -1
79 {} {0.25 0.25 0} Au 1 -1
79 {} {0.25 0.5 0.25} Au 1 -1
79 {} {0.5 0.75 0.75} Au 1 -1
79 {} {0.5 0 0} Au 1 -1
79 {} {0.5 0.25 0.25} Au 1 -1
79 {} {0.5 0.5 0.5} Au 1 -1
79 {} {0.25 0.5 0.75} Au 1 -1
79 {} {0.5 0.25 0.75} Au 1 -1
79 {} {0.5 0.5 0} Au 1 -1
@end
@Columns Cell
	Constraints	string	{a b c A B G}
	Origin	int	{{0 0 0}}
	Parameters	double	{{10.0 10.0 10.0 90.0 90.0 90.0}}
	PrimitiveData	double	{{{1.0 0.0 0.0} {0.0 1.0 0.0} {0.0 0.0 1.0}}}
	RotationMatrix	double	{{{1.0 0.0 0.0} {0.0 1.0 0.0} {0.0 0.0 1.0}}}
	SpaceGroup	string	P1
	SpaceGroupNumber	int	1
	ToCartesians	double	{{{10.0 0.0 0.0} {0.0 10.0 0.0} {0.0 0.0 10.0}}}
	ToFractionals	double	{{{0.10000000000000001 0.0 0.0} {0.0 0.10000000000000001 0.0} {0.0 0.0 0.10000000000000001}}}
@end
@data
{a b c A B G} {0 0 0} {8.255200776 8.255200776 8.255200776 90 90 90} {{1 0 0} {0 1 0} {0 0 1}} {{1 0 0} {0 1 0} {0 0 1}} P1 1 {{8.255200776 0 0} {1.51364046422e-007 8.255200776 0} {1.51364046422e-007 1.51364043647e-007 8.255200776}} {{0.121135757583 0 0} {-2.22109660706e-009 0.121135757583 0} {-2.22109656633e-009 -2.22109656633e-009 0.121135757583}}
@end
@Columns AsymmetricBond
	Atom1	reference	AsymmetricAtom
	Atom2	reference	AsymmetricAtom
	Key	int	0
	Order	int	0
@end
@data
@end
@Columns Bond
	AsymmetricBond	reference	AsymmetricBond
	Atom1	reference	Atom
	Atom2	reference	Atom
	CellOffset2	int	{{0 0 0}}
	Key	int	0
@end
@data
@end