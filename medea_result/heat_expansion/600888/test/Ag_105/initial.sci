#MD System 2.0

@Title Untitled

@Columns AsymmetricAtom
	AtomicNumber	int	0
	Connections	string	{{}}
	Fractional	double	{{0.0 0.0 0.0}}
	Name	string	{{}}
	Site	int	1
	WyckoffPosition	int	-1
@end
@data
47 {} {0 0 0} Ag 1 1
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
{a b c A B G} {0 0 0} {4.37195758258 4.37195758258 4.37195758258 90 90 90} {{1 0 0} {0 1 0} {0 0 1}} {{1 0 0} {0 1 0} {0 0 1}} Fm-3m 225 {{4.37195758258 0 0} {8.01624586054e-008 4.37195758258 0} {8.01624586054e-008 8.01624571356e-008 4.37195758258}} {{0.228730489972 0 0} {-4.19391041378e-009 0.228730489972 0} {-4.19391033688e-009 -4.19391033688e-009 0.228730489972}}
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
@Columns Subset
	Criteria	string	{{}}
	Dynamic	int	0
	Length	int	1
	Name	string	{{}}
	Table	string	{{}}
	Type	string	atom
@end
@data
@end
