# Maintainer: Yajat Ghule <287946878+YajatGhule@users.noreply.github.com>
pkgname=arch-safe-update
pkgver=1.0.0
pkgrel=1
pkgdesc="Cat-themed safe system updater: Timeshift snapshot, update preview, yay -Syu, AUR rebuild check"
arch=('any')
url="https://github.com/YajatGhule/arch-safe-update"
license=('MIT')
depends=('bash' 'yay' 'pacman-contrib' 'rebuild-detector' 'timeshift' 'sudo')
optdepends=('fprintd: restart and check the fingerprint sensor after updating')
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('c910e50275d2349da1fbfb8dd35ac0a00e080573163611837465f39c1aadca06')

package() {
  cd "$pkgname-$pkgver"
  install -Dm755 safe-update "$pkgdir/usr/bin/safe-update"
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
