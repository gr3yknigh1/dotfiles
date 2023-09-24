ifndef HOME
$(error HOME variable not defined. Something is wrong here)
endif

.PHONY: default dirs install-stow-packages install-paru


MKDIR = mkdir -p

STOW_PKGS_DIR = $(CURDIR)/stows
STOW_CMD  = /bin/stow -t $(HOME) -d $(STOW_PKGS_DIR) --verbose=0
STOW_PKGS = nvim lazygit tmux bash kitty ranger fish dunst templates vim

DIRS = Desktop Downloads Documents Templates
DIRS += Pictures Pictures/Camera Pictures/Wallpapers
DIRS += Videos Videos/OBS Videos/Films
DIRS += workspace workspace/projects workspace/forks workspace/avsoft
DIRS += workspace/testing workspace/notes
DIRS += .config .local .local/bin .local/share .local/share/applications

default:

dirs:
	@for dir in $(DIRS); do \
		test -d $(HOME)/$$dir || $(MKDIR) $(HOME)/$$dir; \
	done

## PARU - AUR Helper
PARU_URL := https://aur.archlinux.org/paru.git
PARU_DIR := /opt/paru

install-paru:
	sudo pacman -S --needed base-devel
	@ if [ -d /opt/paru ]; then \
		sudo chown -R $(USER) $(PARU_DIR); \
		git -C $(PARU_DIR) fetch; \
		git -C $(PARU_DIR) pull; \
	else \
		sudo git clone $(PARU_URL) $(PARU_DIR); \
		sudo chown -R $(USER) $(PARU_DIR); \
	fi
	cd $(PARU_DIR); makepkg -si --noconfirm --needed


### NERD FONTS
NERD_FONTS_URL := https://github.com/ryanoasis/nerd-fonts.git
NERD_FONTS_DIR := /opt/nerd-fonts
NERD_FONTS_TAG := v3.0.1

install-nerd-fonts:
	@ if [ -d $(NERD_FONTS_DIR) ]; then \
		sudo chown -R $(USER) $(NERD_FONTS_DIR); \
		git -C $(NERD_FONTS_DIR) fetch; \
		git -C $(NERD_FONTS_DIR) pull; \
	else \
		sudo git clone --depth 1 -b $(NERD_FONTS_TAG) -- $(NERD_FONTS_URL) $(NERD_FONTS_DIR); \
		sudo chown -R $(USER) $(NERD_FONTS_DIR); \
	fi
	sh $(NERD_FONTS_DIR)/install.sh


install-stow-pkgs: dirs
	@ for pkg in $(STOW_PKGS); do \
		$(STOW_CMD) -S $$pkg; \
	done


uninstall-stow-pkgs:
	@ for pkg in $(STOW_PKGS); do \
		$(STOW_CMD) -D $$pkg; \
	done

### SSH for git
GIT_SSH_PRIVATE_KEY=$(HOME)/.ssh/id_rsa
GIT_SSH_PUBLIC_KEY=$(HOME)/.ssh/id_rsa.pub
# TODO: Find way to check what clipping util is installed
COPY_TO_CLIPBOARD=wl-copy
CAT=cat

# TODO: Exit if `USER_EMAIL` not setted
# TODO: Run `ssh-agent` only if it's not already running
# NOTE: ^^^ When I running it several times it not running twice
ssh-key:
	@ if [ ! -z $(USER_EMAIL) ]; then                                                         \
		if [ ! -f $(GIT_SSH_PRIVATE_KEY) ] || [ ! -f $(GIT_SSH_PUBLIC_KEY) ]; then            \
			echo "Regenerating public key...";                                                \
			                                                                                  \
			if [ -f $(GIT_SSH_PUBLIC_KEY) ]; then                                             \
				echo "Backup $(GIT_SSH_PUBLIC_KEY) -> $(GIT_SSH_PUBLIC_KEY).old";             \
				mv $(GIT_SSH_PUBLIC_KEY) $(GIT_SSH_PUBLIC_KEY).old;                           \
			fi;                                                                               \
			                                                                                  \
			if [ -f $(GIT_SSH_PRIVATE_KEY) ]; then                                            \
				echo "Backup $(GIT_SSH_PRIVATE_KEY) -> $(GIT_SSH_PRIVATE_KEY).old";           \
				mv $(GIT_SSH_PRIVATE_KEY) $(GIT_SSH_PRIVATE_KEY).old;                         \
			fi;                                                                               \
			                                                                                  \
			ssh-keygen -t rsa -b 4096 -C "$(USER_EMAIL)" -N "" -f $(GIT_SSH_PRIVATE_KEY) -q ; \
		fi;                                                                                   \
		eval "$(ssh-agent -s)";                                                               \
		echo "Copied public key to clipboard";                                                \
		$(CAT) $(GIT_SSH_PUBLIC_KEY) | $(COPY_TO_CLIPBOARD);                                  \
	else                                                                                      \
		echo "USER_EMAIL variable not found";                                                 \
	fi

### TPM for tmux
TPM_URL := https://github.com/tmux-plugins/tpm
TPM_DIR := ~/.config/tmux/plugins/tpm

install-tpm:
	git clone $(TPM_URL) $(TPM_DIR)

