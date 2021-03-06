! N   : number of particles 
! a   : lattice spacing
! T   : temperatute
! pos : position of particles   --> (N,3) array
! v   : velocities of particles --> (N,3) array
! rho : density of the system

subroutine initialize_r(pos,rho,N,L)

implicit none
integer, intent(in)   :: N
real, intent(in)      :: rho
real, intent(out)     :: pos(N,3)
real, intent(out)     :: L
real                  :: a, kinetic
integer               :: i, j, k, cont, M
integer, dimension(3) :: R

! Initialization of the structure

M = int((N/4.0)**(1.0/3.0))
L = (N/rho)**(1.0/3.0)
a = L/M 

cont = 0

do i = 0, M-1
    do j = 0, M-1
        do k = 0, M-1
            R = (/i,j,k/)
            pos(4*cont+1,:) = a*R
            pos(4*cont+2,:) = a*R + pos(1,:) + a*0.5*(/1.0,1.0,0.0/)
            pos(4*cont+3,:) = a*R + pos(1,:) + a*0.5*(/0.0,1.0,1.0/)
            pos(4*cont+4,:) = a*R + pos(1,:) + a*0.5*(/1.0,0.0,1.0/)
            cont = cont + 1
        enddo
    enddo
enddo

end subroutine initialize_r

subroutine initialize_v(v,T,N)

real, intent(out)   :: v(N,3) 
integer, intent(in) :: N
real, intent(in)    :: T
integer             :: i

! Initialization of velocities

call random_number(v)
v = v - 0.5

! Make sure that the total velocity of the system is zero
do i = 1, 3
   v(:,i) = v(:,i) - sum(v(:,i))/N
enddo

! Rescale the velocities with the temperature
kinetic = 0.5 * sum(v**2.0)
v = v * sqrt(1.5 * N * T / kinetic) 

end subroutine initialize_v
