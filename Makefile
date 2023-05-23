ifndef HOME
$(error HOME variable not defined. Something is wrong here)
endif

.PHONY: default dirs install-stow-packages install-paru


MKDIR = mkdir -p

STOW_PKGS_DIR = $(CURDIR)/stow-pkgs
STOW_CMD  = /bin/stow -t $(HOME) -d $(STOW_PKGS_DIR) --verbose=0
STOW_PKGS = sway nvim lazygit tmux bash alacritty

DIRS = Desktop Downloads Documents Templates
DIRS += Pictures Pictures/Camera Pictures/Wallpapers
DIRS += Videos Videos/OBS Videos/Films
DIRS += Workspace Workspace/Projects Workspace/Forks Workspace/AVSoft Workspace/Testing Workspace/Chaos
DIRS += .config .local .local/bin .local/share

default:

dirs:
	@for dir in $(DIRS); do \
		test -d $(HOME)/$$dir || $(MKDIR) $(HOME)/$$dir; \
	done

## PARU - AUR Helper
PARU_DIR := /opt/paru

install-paru:
	sudo pacman -S --needed base-devel
	@ if [ -d /opt/paru ]; then \
		sudo chown -R $(USER) $(PARU_DIR); \
		git -C $(PARU_DIR) fetch; \
		git -C $(PARU_DIR) pull; \
	else \
		sudo git clone https://aur.archlinux.org/paru.git $(PARU_DIR); \
		sudo chown -R $(USER) $(PARU_DIR); \
	fi
	cd $(PARU_DIR); makepkg -si --noconfirm --needed


### NERD FONTS
NERD_FONTS_DIR := /opt/nerd-fonts
NERD_FONTS_TAG := v3.0.1

install-nerd-fonts:
	@ if [ -d $(NERD_FONTS_DIR) ]; then \
		sudo chown -R $(USER) $(NERD_FONTS_DIR); \
		git -C $(NERD_FONTS_DIR) fetch; \
		git -C $(NERD_FONTS_DIR) pull; \
	else \
		sudo git clone --depth 1 -b $(NERD_FONTS_TAG) -- https://github.com/ryanoasis/nerd-fonts.git $(NERD_FONTS_DIR); \
		sudo chown -R $(USER) $(NERD_FONTS_DIR); \
	fi
	sh $(NERD_FONTS_DIR)/install.sh


install-stow-pkgs: dirs
	@for pkg in $(STOW_PKGS); do \
		$(STOW_CMD) -S $$pkg; \
	done

